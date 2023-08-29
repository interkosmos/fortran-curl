! gopher.f90
!
! Example that shows how to access the Gopher Space, using libcurl.
!
! Author:  Philipp Engel
! Licence: ISC
module gopher_callback
    use, intrinsic :: iso_fortran_env, only: i8 => int64
    use :: curl, only: c_f_str_ptr
    implicit none
    private

    type, public :: response_type
        character(len=:), allocatable :: content
    end type response_type

    public  :: response_callback
contains
    ! static size_t callback(char *ptr, size_t size, size_t nmemb, void *data)
    function response_callback(ptr, sze, nmemb, data) bind(c)
        !! Callback function for `CURLOPT_WRITEFUNCTION` that stores the
        !! response chunk in derived type `response_type`.
        use, intrinsic :: iso_c_binding, only: c_associated, c_f_pointer, c_ptr, c_size_t
        type(c_ptr),            intent(in), value :: ptr               !! C pointer to a chunk of the response.
        integer(kind=c_size_t), intent(in), value :: sze               !! Always 1.
        integer(kind=c_size_t), intent(in), value :: nmemb             !! Size of the response chunk.
        type(c_ptr),            intent(in), value :: data              !! C pointer to argument passed by caller.
        integer(kind=c_size_t)                    :: response_callback !! Function return value.
        type(response_type), pointer              :: response          !! Stores response.
        character(len=:), allocatable             :: tmp

        response_callback = int(0, kind=c_size_t)

        if (.not. c_associated(ptr)) return
        if (.not. c_associated(data)) return

        call c_f_str_ptr(ptr, tmp, int(nmemb, kind=i8))
        call c_f_pointer(data, response)

        if (.not. allocated(response%content)) &
            response%content = ''

        response%content = response%content // tmp

        deallocate (tmp)
        response_callback = nmemb
    end function response_callback
end module gopher_callback

module gopher
    implicit none
    private
    character, parameter :: NL = new_line('A')

    type, public :: gopher_item_type
        character(len=1)              :: item_type
        character(len=:), allocatable :: label
        character(len=:), allocatable :: selector
        character(len=:), allocatable :: host
        integer                       :: port
    end type gopher_item_type

    private :: count_sub_string
    private :: split
    public  :: read_gopher_map
contains
    function count_sub_string(s1, s2) result(c)
        !! Returns the number of occurences of string `s2` in string `s1`.
        character(len=*), intent(in) :: s1
        character(len=*), intent(in) :: s2
        integer                      :: c
        integer                      :: p, pos_n

        c = 0
        p = 1

        if (len(s2) == 0) return

        do
            pos_n = index(s1(p:), s2)
            if (pos_n == 0) return
            c = c + 1
            p = p + pos_n + len(s2)
        end do
    end function count_sub_string

    subroutine read_gopher_map(string, items)
        !! Tokenises given `string` containing a Gopher map and puts each
        !! line as derived type `gopher_item_type` into `items`.
        integer, parameter :: MAX_LEN = 4096 !! Maximum length of each line in Gopher map.

        character(len=*),                    intent(in)  :: string         !! String of Gopher map.
        type(gopher_item_type), allocatable, intent(out) :: items(:)       !! Array of Gopher map items.

        character(len=MAX_LEN), allocatable :: lines(:)  ! Array of file lines.
        character(len=256)                  :: tokens(4) ! Array of tokenised line string.
        integer                             :: i, n, rc

        ! Number of lines in Gopher map.
        n = count_sub_string(string, NL) + 1

        allocate (lines(n))
        allocate (items(n))

        ! Split file into lines.
        call split(string, lines, NL)

        ! Tokenise the lines.
        do i = 1, n
            ! Split line by tabular.
            call split(lines(i), tokens, achar(9))

            items(i)%item_type = tokens(1)(1:1)
            items(i)%label     = trim(tokens(1)(2:))
            items(i)%selector  = trim(tokens(2))
            items(i)%host      = trim(tokens(3))

            ! Convert string to integer.
            read (tokens(4), *, iostat=rc) items(i)%port
        end do

        deallocate (lines)
    end subroutine read_gopher_map

    subroutine split(str, array, del)
        !! Splits a string by a given delimiter into an array of strings.
        character(len=*), intent(in)    :: str
        character(len=*), intent(inout) :: array(:)
        character(len=*), intent(in)    :: del
        integer                         :: n, pos1, pos2

        pos1 = 1
        n    = 0

        do
            pos2 = index(str(pos1:), del)

            if (pos2 == 0) then
                n = n + 1
                if (n > size(array)) exit
                array(n) = str(pos1:)
                exit
            end if

            n = n + 1
            array(n) = str(pos1:pos1 + pos2 - 2)
            pos1 = pos1 + pos2
        end do
    end subroutine split
end module gopher

program main
    use, intrinsic :: iso_c_binding
    use :: gopher_callback
    use :: curl
    use :: gopher
    implicit none

    character(len=*), parameter :: DEFAULT_PROTOCOL = 'gopher'
    character(len=*), parameter :: DEFAULT_URL      = 'gopher://gopher.floodgap.com/'

    integer                             :: i, rc
    type(c_ptr)                         :: curl_ptr
    type(gopher_item_type), allocatable :: items(:)
    type(response_type), target         :: response

    rc = curl_global_init(CURL_GLOBAL_DEFAULT)
    curl_ptr = curl_easy_init()

    if (.not. c_associated(curl_ptr)) stop 'Error: curl_easy_init() failed'

    ! Set curl options.
    rc = curl_easy_setopt(curl_ptr, CURLOPT_DEFAULT_PROTOCOL, DEFAULT_PROTOCOL)
    rc = curl_easy_setopt(curl_ptr, CURLOPT_URL,              DEFAULT_URL)
    rc = curl_easy_setopt(curl_ptr, CURLOPT_WRITEFUNCTION,    c_funloc(response_callback))
    rc = curl_easy_setopt(curl_ptr, CURLOPT_WRITEDATA,        c_loc(response))

    ! Send request.
    rc = curl_easy_perform(curl_ptr)
    call curl_easy_cleanup(curl_ptr)
    call curl_global_cleanup()

    if (rc /= CURLE_OK) stop 'Error: curl_easy_perform() failed'

    call read_gopher_map(trim(response%content), items)

    ! Print Gopher map to screen.
    if (.not. allocated(items)) stop 'Error: parsing Gopher map failed'

    do i = 1, size(items)
        print '(a)', items(i)%label
    end do
end program main
