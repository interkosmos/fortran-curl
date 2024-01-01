! mqtt.f90
!
! Sends message to MQTT topic, using libcurl.
!
! Author:  Philipp Engel
! Licence: ISC
program main
    use, intrinsic :: iso_c_binding
    use :: curl
    implicit none

    character(len=*), parameter :: URL = 'mqtt://localhost:1883/fortran'

    integer     :: rc
    type(c_ptr) :: curl_ptr

    character(len=:), allocatable, target :: payload

    rc = curl_global_init(CURL_GLOBAL_DEFAULT)
    curl_ptr = curl_easy_init()

    if (.not. c_associated(curl_ptr)) then
        stop 'Error: curl_easy_init() failed'
    end if

    payload = 'Hello, from Fortran!'

    ! Set curl options.
    rc = curl_easy_setopt(curl_ptr, CURLOPT_URL,            URL)
    rc = curl_easy_setopt(curl_ptr, CURLOPT_CONNECTTIMEOUT, 10)
    rc = curl_easy_setopt(curl_ptr, CURLOPT_NOSIGNAL,       1)
    rc = curl_easy_setopt(curl_ptr, CURLOPT_NOPROGRESS,     1)
    rc = curl_easy_setopt(curl_ptr, CURLOPT_POST,           1)
    rc = curl_easy_setopt(curl_ptr, CURLOPT_POSTFIELDS,     c_loc(payload))
    rc = curl_easy_setopt(curl_ptr, CURLOPT_POSTFIELDSIZE,  len(payload))

    ! Send request.
    rc = curl_easy_perform(curl_ptr)

    if (rc /= CURLE_OK) then
        print '("Error: curl_easy_perform() failed: ", a)', curl_easy_strerror(rc)
    end if

    call curl_easy_cleanup(curl_ptr)
    call curl_global_cleanup()
end program main
