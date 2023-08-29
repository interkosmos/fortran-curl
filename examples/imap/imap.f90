! imap.f90
!
! Example that shows how to examine the INBOX of an IMAP mailbox, using
! libcurl. Based on the following C implementation:
!
!     https://curl.haxx.se/libcurl/c/imap-examine.html
!
! Author:  Philipp Engel
! Licence: ISC
module imap_callback
    use, intrinsic :: iso_c_binding
    use, intrinsic :: iso_fortran_env, only: i8 => int64
    use :: curl, only: c_f_str_ptr
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
        call c_f_str_ptr(ptr, str, int(nmemb, kind=i8))
        write (*, '(a)', advance='no') str
        write_callback = nmemb
    end function write_callback
end module imap_callback

program main
    use, intrinsic :: iso_c_binding
    use :: curl
    use :: imap_callback
    implicit none

    character(len=*), parameter :: URL      = 'imaps://example.com' ! IMAP server (SSL).
    character(len=*), parameter :: USERNAME = 'user'                ! IMAP user name.
    character(len=*), parameter :: PASSWORD = 'secret'              ! IMAP password.

    type(c_ptr) :: curl_ptr
    integer     :: rc

    rc = curl_global_init(CURL_GLOBAL_DEFAULT)
    curl_ptr = curl_easy_init()
    if (.not. c_associated(curl_ptr)) stop 'Error: curl_easy_init() failed'

    ! Set curl options.
    rc = curl_easy_setopt(curl_ptr, CURLOPT_URL,            URL)
    rc = curl_easy_setopt(curl_ptr, CURLOPT_USERNAME,       USERNAME)
    rc = curl_easy_setopt(curl_ptr, CURLOPT_PASSWORD,       PASSWORD)
    rc = curl_easy_setopt(curl_ptr, CURLOPT_CUSTOMREQUEST,  'EXAMINE INBOX')
    rc = curl_easy_setopt(curl_ptr, CURLOPT_SSL_VERIFYPEER, 1)
    rc = curl_easy_setopt(curl_ptr, CURLOPT_SSL_VERIFYHOST, 1)
    rc = curl_easy_setopt(curl_ptr, CURLOPT_WRITEFUNCTION,  c_funloc(write_callback))
    rc = curl_easy_setopt(curl_ptr, CURLOPT_VERBOSE,        1)

    ! Perform request..
    if (curl_easy_perform(curl_ptr) /= CURLE_OK) then
        print '(a)', 'Error: curl_easy_perform() failed'
    end if

    call curl_easy_cleanup(curl_ptr)
    call curl_global_cleanup()
end program main
