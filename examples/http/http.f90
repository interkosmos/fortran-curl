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
contains
    ! static size_t callback(char *ptr, size_t size, size_t nmemb, void *data)
    function response_callback(ptr, size, nmemb, data) bind(c)
        !! Callback function for `CURLOPT_WRITEFUNCTION` that simply outputs
        !! the returned HTTP response.
        !!
        !! This callback function might be called several times by libcurl,
        !! passing in chunks of the response. The chunks are concatenated with
        !! the parts of the response already in the database.
        use, intrinsic :: iso_c_binding, only: c_associated, c_ptr, c_size_t
        type(c_ptr),            intent(in), value :: ptr               !! C pointer to a chunk of the response.
        integer(kind=c_size_t), intent(in), value :: size              !! Always 1.
        integer(kind=c_size_t), intent(in), value :: nmemb             !! Size of the response chunk.
        type(c_ptr),            intent(in), value :: data              !! C pointer to argument passed by caller.
        integer(kind=c_size_t)                    :: response_callback !! Function return value.
        character(len=:), allocatable             :: response          !! Response string.

        response_callback = int(0, kind=c_size_t)

        if (.not. c_associated(ptr)) return

        ! Convert C char pointer to Fortran string.
        allocate (character(len=nmemb) :: response)
        call c_f_string_ptr(ptr, response)

        ! Print HTTP response to stdout.
        print '(a)', response
        deallocate (response)

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
        else
            call c_f_pointer(c_string, char_ptrs, [ huge(0) ])

            i = 1

            do while (char_ptrs(i) /= c_null_char .and. i <= len(f_string))
                f_string(i:i) = char_ptrs(i)
                i = i + 1
            end do

            if (i < len(f_string)) &
                f_string(i:) = ' '
        end if
    end subroutine c_f_string_ptr
end module callback

program main
    use, intrinsic :: iso_c_binding, only: c_associated, c_funloc, c_null_char, c_null_ptr, c_ptr
    use :: curl
    use :: callback
    implicit none

    character(len=*), parameter :: DEFAULT_PROTOCOL = 'http'
    character(len=*), parameter :: DEFAULT_URL      = 'http://info.cern.ch/hypertext/WWW/TheProject.html'
    type(c_ptr)                 :: curl_ptr
    integer                     :: rc

    curl_ptr = curl_easy_init()

    if (.not. c_associated(curl_ptr)) then
        stop 'Error: curl_easy_init() failed'
    end if

    ! Set curl options.
    rc = curl_easy_setopt_char(curl_ptr, CURLOPT_DEFAULT_PROTOCOL, DEFAULT_PROTOCOL // c_null_char)
    rc = curl_easy_setopt_char(curl_ptr, CURLOPT_URL,              DEFAULT_URL // c_null_char)
    rc = curl_easy_setopt_long(curl_ptr, CURLOPT_FOLLOWLOCATION,   int( 1, kind=8))
    rc = curl_easy_setopt_long(curl_ptr, CURLOPT_TIMEOUT,          int(10, kind=8))
    rc = curl_easy_setopt_long(curl_ptr, CURLOPT_NOSIGNAL,         int( 1, kind=8))
    rc = curl_easy_setopt_long(curl_ptr, CURLOPT_CONNECTTIMEOUT,   int(10, kind=8))
    rc = curl_easy_setopt_fptr(curl_ptr, CURLOPT_WRITEFUNCTION,    c_funloc(response_callback))
    rc = curl_easy_setopt_ptr(curl_ptr,  CURLOPT_WRITEDATA,        c_null_ptr)

    ! Send request.
    if (curl_easy_perform(curl_ptr) /= CURLE_OK) then
        print '(a)', 'Error: curl_easy_perform() failed'
    end if

    call curl_easy_cleanup(curl_ptr)
end program main
