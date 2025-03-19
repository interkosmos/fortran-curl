! smtp.f90
!
! Example that shows how to send an e-mail via SMTP with SSL encryption using
! libcurl. Based on the following C implementation:
!
!     https://curl.haxx.se/libcurl/c/smtp-ssl.html
!
! Author:  Philipp Engel
! Licence: ISC
module smtp_callback
    use, intrinsic :: iso_c_binding
    use, intrinsic :: iso_fortran_env, only: i8 => int64
    implicit none
    private
    public :: read_callback

    ! Client data for `read_callback()`.
    type, public :: payload_type
        character(len=:), allocatable :: data
        integer(kind=i8)              :: length = 0_i8
        integer(kind=i8)              :: nbytes = 0_i8
    end type payload_type
contains
    function read_callback(ptr, sz, nmemb, data) bind(c) result(n)
        !! Callback function to upload payload passed via `data` to the
        !! memory chunk in `ptr`.
        type(c_ptr),            intent(in), value :: ptr   !! C pointer to a chunk of memory.
        integer(kind=c_size_t), intent(in), value :: sz    !! Always 1.
        integer(kind=c_size_t), intent(in), value :: nmemb !! Size of the memory chunk.
        type(c_ptr),            intent(in), value :: data  !! C pointer to argument passed by caller.
        integer(kind=c_size_t)                    :: n     !! Function return value.

        character(len=nmemb), pointer :: chunk
        integer(kind=i8)              :: length, room
        type(payload_type),   pointer :: payload

        n = int(0, kind=c_size_t)
        room = sz * nmemb

        if (sz == 0 .or. nmemb == 0 .or. room < 1) return
        if (.not. c_associated(ptr) .or. .not. c_associated(data)) return

        chunk   => null()
        payload => null()

        call c_f_pointer(ptr, chunk)
        call c_f_pointer(data, payload)

        if (.not. associated(chunk)) return
        if (.not. associated(payload)) return

        if (.not. allocated(payload%data) .or. payload%length <= 0) return
        if (payload%nbytes == payload%length) return

        length = payload%length - payload%nbytes
        if (room < length) length = room

        chunk = payload%data(payload%nbytes + 1:payload%nbytes + length)
        payload%nbytes = payload%nbytes + length

        n = int(length, kind=c_size_t)
    end function read_callback
end module smtp_callback

program main
    use, intrinsic :: iso_c_binding
    use :: curl
    use :: smtp_callback
    implicit none

    character(len=*), parameter :: CRLF     = achar(13) // achar(10)
    character(len=*), parameter :: FROM     = '<mail@example.com>'      ! Sender of mail.
    character(len=*), parameter :: TO       = '<to@example.com>'        ! Mail receiver.
    character(len=*), parameter :: CC       = '<cc@example.com>'        ! CC mail receiver.
    character(len=*), parameter :: SUBJECT  = 'A message from Fortran'  ! Mail subject.
    character(len=*), parameter :: URL      = 'smtps://example.com'     ! SMTP server (SSL).
    character(len=*), parameter :: USERNAME = 'mail@example.com'        ! SMTP user name.
    character(len=*), parameter :: PASSWORD = 'secret'                  ! SMTP password.

    type(c_ptr)                :: curl_ptr
    type(c_ptr)                :: list_ptr
    type(payload_type), target :: payload
    integer                    :: rc

    ! Plain text mail.
    payload%data = 'Date: '    // rfc2822() // CRLF // &
                   'To: '      // TO        // CRLF // &
                   'From: '    // FROM      // CRLF // &
                   'Cc: '      // CC        // CRLF // &
                   'Subject: ' // SUBJECT   // CRLF // &
                   CRLF // &
                   'Hello, from Fortran!' // CRLF // &
                   CRLF

    ! Initialise cURL.
    rc = curl_global_init(CURL_GLOBAL_DEFAULT)
    curl_ptr = curl_easy_init()
    if (.not. c_associated(curl_ptr)) stop 'Error: curl_easy_init() failed'

    ! Add recipients.
    list_ptr = curl_slist_append(c_null_ptr, TO)
    list_ptr = curl_slist_append(list_ptr,   CC)

    ! Set cURL options.
    rc = curl_easy_setopt(curl_ptr, CURLOPT_URL,            URL)
    rc = curl_easy_setopt(curl_ptr, CURLOPT_USERNAME,       USERNAME)
    rc = curl_easy_setopt(curl_ptr, CURLOPT_PASSWORD,       PASSWORD)
    rc = curl_easy_setopt(curl_ptr, CURLOPT_SSL_VERIFYPEER, 1)
    rc = curl_easy_setopt(curl_ptr, CURLOPT_SSL_VERIFYHOST, 1)
    rc = curl_easy_setopt(curl_ptr, CURLOPT_MAIL_FROM,      FROM)
    rc = curl_easy_setopt(curl_ptr, CURLOPT_MAIL_RCPT,      list_ptr)
    rc = curl_easy_setopt(curl_ptr, CURLOPT_READDATA,       c_loc(payload))
    rc = curl_easy_setopt(curl_ptr, CURLOPT_READFUNCTION,   c_funloc(read_callback))
    rc = curl_easy_setopt(curl_ptr, CURLOPT_UPLOAD,         1)
    rc = curl_easy_setopt(curl_ptr, CURLOPT_VERBOSE,        1)

    ! Send e-mail.
    if (curl_easy_perform(curl_ptr) /= CURLE_OK) then
        print '("Error: curl_easy_perform() failed")'
    end if

    call curl_slist_free_all(list_ptr)
    call curl_easy_cleanup(curl_ptr)
    call curl_global_cleanup()
contains
    function rfc2822()
        ! Returns current time and date in RFC 2822 format:
        !
        !     https://www.ietf.org/rfc/rfc2822.txt
        !
        ! Example: `Thu, 01 Sep 2016 10:11:12 -0500`.
        use, intrinsic :: iso_fortran_env, only: i8 => int64
        character(len=3), parameter :: DAYS(7)    = [ 'Sun', 'Mon', 'Thu', 'Wed', 'Thu', 'Fri', 'Sat' ]
        character(len=3), parameter :: MONTHS(12) = [ 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', &
                                                      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec' ]

        character(len=*), parameter :: DT_FMT  = '(a, ", ", i0.2, " ", a, " ", i4, " ", ' // &
                                                 'i0.2, ":", i0.2, ":", i0.2, " ", a)'
        character(len=31) :: rfc2822
        character(len=5)  :: z
        integer(kind=i8)  :: dt(8), w

        call date_and_time(zone=z, values=dt)
        w = 1 + modulo(dt(1) + int((dt(1) - 1) / 4) - int((dt(1) - 1) / 100) + int((dt(1) - 1) / 400), &
                       int(7, kind=i8))
        write (rfc2822, DT_FMT) DAYS(w), dt(3), MONTHS(dt(2)), dt(1), dt(5), dt(6), dt(7), z
    end function rfc2822
end program main
