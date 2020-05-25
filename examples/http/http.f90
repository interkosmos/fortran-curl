! http.f90
!
! Basic HTTP client in Fortran, using libcurl.
!
! Author:  Philipp Engel
! Licence: ISC
module callback
    implicit none
    private
    public :: response_callback

    integer(kind=8), parameter, public :: MAX_SIZE = 4096

    type, public :: response_type
        character(len=MAX_SIZE) :: content
        integer(kind=8)         :: size
    end type response_type
contains
    ! static size_t callback(char *ptr, size_t size, size_t nmemb, void *data)
    function response_callback(ptr, size, nmemb, data) bind(c)
        !! Callback function for `CURLOPT_WRITEFUNCTION` that appends the
        !! response chunk `ptr` to the given `data` of type `response_type`.
        !!
        !! This callback function might be called several times by libcurl,
        !! passing in more chunks of the response.
        use, intrinsic :: iso_c_binding, only: c_associated, c_f_pointer, c_ptr, c_size_t
        type(c_ptr),            intent(in), value :: ptr               !! C pointer to a chunk of the response.
        integer(kind=c_size_t), intent(in), value :: size              !! Always 1.
        integer(kind=c_size_t), intent(in), value :: nmemb             !! Size of the response chunk.
        type(c_ptr),            intent(in), value :: data              !! C pointer to argument passed by caller.
        integer(kind=c_size_t)                    :: response_callback !! Function return value.
        type(response_type), pointer              :: response          !! Stores response.
        character(len=:), allocatable             :: tmp
        integer(kind=8)                           :: i, j

        response_callback = int(0, kind=c_size_t)

        if (.not. c_associated(ptr)) return
        if (.not. c_associated(data)) return

        allocate (character(len=nmemb) :: tmp)
        call c_f_string_ptr(ptr, tmp)
        call c_f_pointer(data, response)

        if (response%size == 0) then
            response%content = tmp
        else
            i = response%size + 1
            j = i + nmemb

            if (i > MAX_SIZE) return
            if (j > MAX_SIZE) j = MAX_SIZE

            response%content(i:j) = tmp
        end if

        response%size = response%size + nmemb

        deallocate (tmp)
        response_callback = nmemb
    end function response_callback

    subroutine c_f_string_ptr(c_string, f_string)
        !! Utility routine that copies a C string, passed as a C pointer, to a
        !! Fortran string.
        use, intrinsic :: iso_c_binding, only: c_associated, c_char, c_f_pointer, c_null_char, c_ptr
        type(c_ptr),      intent(in)           :: c_string
        character(len=*), intent(out)          :: f_string
        character(kind=c_char, len=1), pointer :: char_ptrs(:)
        integer                                :: i

        if (.not. c_associated(c_string)) then
            f_string = ' '
            return
        end if

        call c_f_pointer(c_string, char_ptrs, [ huge(0) ])
        i = 1

        do while (char_ptrs(i) /= c_null_char .and. i <= len(f_string))
            f_string(i:i) = char_ptrs(i)
            i = i + 1
        end do

        if (i < len(f_string)) f_string(i:) = ' '
    end subroutine c_f_string_ptr
end module callback

program main
    use, intrinsic :: iso_c_binding, only: c_associated, c_funloc, c_loc, c_null_char, &
                                           c_null_ptr, c_ptr
    use :: curl
    use :: callback
    implicit none

    character(len=*), parameter :: DEFAULT_PROTOCOL = 'http'
    character(len=*), parameter :: DEFAULT_URL      = 'http://worldtimeapi.org/api/timezone/Europe/London.txt'
!    character(len=*), parameter :: DEFAULT_URL      = 'https://de.wikipedia.org/'
    type(c_ptr)                 :: curl_ptr
    integer                     :: rc
    type(response_type), target :: response

    curl_ptr = curl_easy_init()

    if (.not. c_associated(curl_ptr)) then
        stop 'Error: curl_easy_init() failed'
    end if

    ! Set curl options.
    rc = curl_easy_setopt(curl_ptr, CURLOPT_DEFAULT_PROTOCOL, DEFAULT_PROTOCOL // c_null_char)
    rc = curl_easy_setopt(curl_ptr, CURLOPT_URL,              DEFAULT_URL // c_null_char)
    rc = curl_easy_setopt(curl_ptr, CURLOPT_FOLLOWLOCATION,   int( 1, kind=8))
    rc = curl_easy_setopt(curl_ptr, CURLOPT_TIMEOUT,          int(10, kind=8))
    rc = curl_easy_setopt(curl_ptr, CURLOPT_NOSIGNAL,         int( 1, kind=8))
    rc = curl_easy_setopt(curl_ptr, CURLOPT_CONNECTTIMEOUT,   int(10, kind=8))
    rc = curl_easy_setopt(curl_ptr, CURLOPT_WRITEFUNCTION,    c_funloc(response_callback))
    rc = curl_easy_setopt(curl_ptr, CURLOPT_WRITEDATA,        c_loc(response))

    ! Send request.
    if (curl_easy_perform(curl_ptr) /= CURLE_OK) then
        print '(a)', 'Error: curl_easy_perform() failed'
    end if

    call curl_easy_cleanup(curl_ptr)

    ! Output response.
    print '(a)', trim(response%content)
end program main
