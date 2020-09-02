! imap.f90
!
! Example that shows how to examine the INBOX of an IMAP mailbox, using
! libcurl. Based on the following C implementation:
!
!     https://curl.haxx.se/libcurl/c/imap-examine.html
!
! Author:  Philipp Engel
! Licence: ISC
module callback
    use, intrinsic :: iso_c_binding
    implicit none
    private
    public :: write_callback
contains
    ! static size_t callback(void *ptr, size_t size, size_t nmemb, void *data)
    function write_callback(ptr, sze, nmemb, data) bind(c)
        !! Callback function for `CURLOPT_WRITEFUNCTION` that simply outputs
        !! the IMAP messages.
        type(c_ptr),            intent(in), value :: ptr
        integer(kind=c_size_t), intent(in), value :: sze
        integer(kind=c_size_t), intent(in), value :: nmemb
        type(c_ptr),            intent(in), value :: data
        integer(kind=c_size_t)                    :: write_callback
        character(len=:), allocatable             :: str

        write_callback = int(0, kind=c_size_t)

        write (*, '(a)') '---'
        write (*, '(a)') '--- CALLBACK INVOKED'
        write (*, '(a)') '---'

        if (.not. c_associated(ptr)) return

        allocate (character(len=nmemb) :: str)
        call c_f_str_ptr(ptr, str)
        write (*, '(a)', advance='no') str
        deallocate (str)

        write_callback = nmemb
    end function write_callback

    subroutine c_f_str_ptr(c_str, f_str)
        !! Utility routine that copies a C string, passed as a C pointer, to a
        !! Fortran string.
        type(c_ptr),      intent(in)           :: c_str
        character(len=*), intent(out)          :: f_str
        character(kind=c_char, len=1), pointer :: chars(:)
        integer                                :: i

        if (.not. c_associated(c_str)) then
            f_str = ' '
            return
        end if

        call c_f_pointer(c_str, chars, [ huge(0) ])
        i = 1

        do while (chars(i) /= c_null_char .and. i <= len(f_str))
            f_str(i:i) = chars(i)
            i = i + 1
        end do

        if (i < len(f_str)) f_str(i:) = ' '
    end subroutine c_f_str_ptr
end module callback

program main
    use, intrinsic :: iso_c_binding
    use :: curl
    use :: callback
    implicit none

    character(len=*), parameter :: URL      = 'imaps://example.com' ! IMAP server (SSL).
    character(len=*), parameter :: USERNAME = 'user'                ! IMAP user name.
    character(len=*), parameter :: PASSWORD = 'secret'              ! IMAP password.

    type(c_ptr) :: curl_ptr
    integer     :: rc

    curl_ptr = curl_easy_init()

    if (c_associated(curl_ptr)) then
        ! Set curl options.
        rc = curl_easy_setopt(curl_ptr, CURLOPT_URL,            URL // c_null_char)
        rc = curl_easy_setopt(curl_ptr, CURLOPT_USERNAME,       USERNAME // c_null_char)
        rc = curl_easy_setopt(curl_ptr, CURLOPT_PASSWORD,       PASSWORD // c_null_char)
        rc = curl_easy_setopt(curl_ptr, CURLOPT_CUSTOMREQUEST,  'EXAMINE INBOX' // c_null_char)
        rc = curl_easy_setopt(curl_ptr, CURLOPT_SSL_VERIFYPEER, int(1, kind=8))
        rc = curl_easy_setopt(curl_ptr, CURLOPT_SSL_VERIFYHOST, int(1, kind=8))
        rc = curl_easy_setopt(curl_ptr, CURLOPT_WRITEFUNCTION,  c_funloc(write_callback))
        rc = curl_easy_setopt(curl_ptr, CURLOPT_VERBOSE,        int(1, kind=8))

        ! Perform request..
        if (curl_easy_perform(curl_ptr) /= CURLE_OK) then
            print '(a)', 'Error: curl_easy_perform() failed'
        end if

        call curl_easy_cleanup(curl_ptr)
    end if
end program main
