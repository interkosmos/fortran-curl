! smtp.f90
!
! Example that shows how to send an e-mail via SMTP with SSL encryption using
! libcurl. Based on the following C implementation:
!
!     https://curl.haxx.se/libcurl/c/smtp-ssl.html
!
! Author:  Philipp Engel
! Licence: ISC
module callback_smtp
    use, intrinsic :: iso_c_binding
    implicit none
    private
    public :: upload_callback

    ! Client data for `upload_callback()`.
    type, public :: upload_type
        character(len=512), allocatable :: payload(:)
        integer                         :: index
    end type upload_type

    interface
        ! void *memcpy(void *dest, const void *src, size_t n)
        function c_memcpy(dest, src, n) bind(c, name='memcpy')
          import :: c_ptr, c_size_t
          type(c_ptr),            intent(in), value :: dest
          type(c_ptr),            intent(in), value :: src
          integer(kind=c_size_t), intent(in), value :: n
          type(c_ptr)                               :: c_memcpy
        end function c_memcpy

        ! size_t strlen(const char *s)
        function c_strlen(s) bind(c, name='strlen')
            import :: c_char, c_size_t
            character(kind=c_char), intent(in) :: s
            integer(c_size_t)                  :: c_strlen
        end function c_strlen
    end interface
contains
    ! static size_t callback(void *ptr, size_t size, size_t nmemb, void *data)
    function upload_callback(ptr, sze, nmemb, data) bind(c)
        !! Callback function for `CURLOPT_READFUNCTION` that copies the payload
        !! of the given `data` ptr (derived type `upload_type`) chunk-wise to
        !! `ptr` and returns the byte count.
        type(c_ptr),            intent(in), value :: ptr
        integer(kind=c_size_t), intent(in), value :: sze
        integer(kind=c_size_t), intent(in), value :: nmemb
        type(c_ptr),            intent(in), value :: data
        integer(kind=c_size_t)                    :: upload_callback
        integer(kind=c_size_t)                    :: n
        type(upload_type), pointer                :: upload
        type(c_ptr)                               :: tmp

        upload_callback = int(0, kind=c_size_t)

        if (sze == 0 .or. nmemb == 0 .or. sze * nmemb < 1) return
        if (.not. c_associated(data)) return

        ! Get upload data.
        call c_f_pointer(data, upload)
        if (.not. allocated(upload%payload)) return

        ! Check if upload of payload is complete.
        if (upload%index >= size(upload%payload)) return

        ! Copy payload to given C pointer.
        upload%index = upload%index + 1
        n   = c_strlen(upload%payload(upload%index))
        tmp = c_memcpy(ptr, c_loc(upload%payload(upload%index)), n)

        ! Return the copied bytes.
        upload_callback = n
    end function upload_callback
end module callback_smtp

program main
    use, intrinsic :: iso_c_binding
    use :: curl
    use :: callback_smtp
    implicit none

    character(len=*), parameter :: CRLF     = achar(13) // achar(10) // c_null_char
    character(len=*), parameter :: FROM     = '<mail@example.com>'      ! Sender of mail.
    character(len=*), parameter :: TO       = '<to@example.com>'        ! Mail receiver.
    character(len=*), parameter :: CC       = '<cc@example.com>'        ! CC mail receiver.
    character(len=*), parameter :: SUBJECT  = 'A message from Fortran'  ! Mail subject.
    character(len=*), parameter :: URL      = 'smtps://example.com'     ! SMTP server (SSL).
    character(len=*), parameter :: USERNAME = 'mail@example.com'        ! SMTP user name.
    character(len=*), parameter :: PASSWORD = 'secret'                  ! SMTP password.

    type(c_ptr)               :: curl_ptr
    type(c_ptr)               :: list_ptr
    type(upload_type), target :: upload
    integer                   :: rc

    allocate (upload%payload(8))
    upload%payload(1) = 'Date: ' // rfc2822() // CRLF
    upload%payload(2) = 'To: ' // TO // CRLF
    upload%payload(3) = 'From: ' // FROM // CRLF
    upload%payload(4) = 'Cc: ' // CC // CRLF
    upload%payload(5) = 'Subject: ' // SUBJECT // CRLF
    upload%payload(6) = CRLF
    upload%payload(7) = 'Hello, from Fortran!' // CRLF
    upload%payload(8) = CRLF
    upload%index = 0

    curl_ptr = curl_easy_init()

    if (c_associated(curl_ptr)) then
        ! Add recipients.
        list_ptr = curl_slist_append(c_null_ptr, TO // c_null_char)
        list_ptr = curl_slist_append(list_ptr,   CC // c_null_char)

        ! Set curl options.
        rc = curl_easy_setopt(curl_ptr, CURLOPT_URL,            URL // c_null_char)
        rc = curl_easy_setopt(curl_ptr, CURLOPT_USERNAME,       USERNAME // c_null_char)
        rc = curl_easy_setopt(curl_ptr, CURLOPT_PASSWORD,       PASSWORD // c_null_char)
        rc = curl_easy_setopt(curl_ptr, CURLOPT_SSL_VERIFYPEER, int(1, kind=8))
        rc = curl_easy_setopt(curl_ptr, CURLOPT_SSL_VERIFYHOST, int(1, kind=8))
        rc = curl_easy_setopt(curl_ptr, CURLOPT_MAIL_FROM,      FROM // c_null_char)
        rc = curl_easy_setopt(curl_ptr, CURLOPT_MAIL_RCPT,      list_ptr)
        rc = curl_easy_setopt(curl_ptr, CURLOPT_READDATA,       c_loc(upload))
        rc = curl_easy_setopt(curl_ptr, CURLOPT_READFUNCTION,   c_funloc(upload_callback))
        rc = curl_easy_setopt(curl_ptr, CURLOPT_UPLOAD,         int(1, kind=8))
        rc = curl_easy_setopt(curl_ptr, CURLOPT_VERBOSE,        int(1, kind=8))

        ! Send e-mail.
        if (curl_easy_perform(curl_ptr) /= CURLE_OK) then
            print '(a)', 'Error: curl_easy_perform() failed'
        end if

        call curl_slist_free_all(list_ptr)
        call curl_easy_cleanup(curl_ptr)
    end if
contains
    function rfc2822()
        ! Returns current time and date in RFC 2822 format:
        !
        !     https://www.ietf.org/rfc/rfc2822.txt
        !
        ! Example: `Thu, 01 Sep 2016 10:11:12 -0500`.
        character(len=3), parameter :: days(7)    = [ 'Sun', 'Mon', 'Thu', 'Wed', 'Thu', 'Fri', 'Sat' ]
        character(len=3), parameter :: months(12) = [ 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', &
                                                      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec' ]
        character(len=*), parameter :: dt_fmt     = '(a, ", ", i0.2, " ", a, " ", i4, " ", ' // &
                                                    'i0.2, ":", i0.2, ":", i0.2, " ", a)'
        character(len=31) :: rfc2822
        character(len=5)  :: z
        integer(kind=8)   :: dt(8), w

        call date_and_time(zone=z, values=dt)
        w = 1 + modulo(dt(1) + int((dt(1) - 1) / 4) - int((dt(1) - 1) / 100) + int((dt(1) - 1) / 400), &
                       int(7, kind=8))
        write (rfc2822, dt_fmt) days(w), dt(3), months(dt(2)), dt(1), dt(5), dt(6), dt(7), z
    end function rfc2822
end program main
