! getinfo.f90
!
! Example that uses getinfo to get request information after completed transfer.
!
! Author:  Philipp Engel
! Licence: ISC
program main
    use, intrinsic :: iso_c_binding
    use :: curl
    implicit none

    character(len=*), parameter    :: DEFAULT_URL = 'https://www.example.com/'
    character(len=:), allocatable  :: str
    integer                        :: code
    integer                        :: rc
    real(kind=8)                   :: total_time
    type(c_ptr)                    :: curl_ptr

    curl_ptr = curl_easy_init()
    if (.not. c_associated(curl_ptr)) stop 'Error: curl_easy_init() failed'

    ! Set curl options.
    rc = curl_easy_setopt(curl_ptr, CURLOPT_URL, DEFAULT_URL // c_null_char)

    ! Send request.
    print '("Sending request ...")'
    rc = curl_easy_perform(curl_ptr)

    if (rc == CURLE_OK) then
        rc = curl_easy_getinfo(curl_ptr, CURLINFO_RESPONSE_CODE, code)

        if (rc == CURLE_OK) then
            print '("Response Code: ", i0)', code
        end if

        rc = curl_easy_getinfo(curl_ptr, CURLINFO_CONTENT_TYPE, str)

        if (rc == CURLE_OK) then
            print '("Content Type.: ", a)', str
        end if

        rc = curl_easy_getinfo(curl_ptr, CURLINFO_TOTAL_TIME, total_time)

        if (rc == CURLE_OK) then
            print '("Total Time...: ", f5.3, " s")', total_time
        end if
    else
        print '("Error: ", a)', curl_easy_strerror(rc)
    end if

    call curl_easy_cleanup(curl_ptr)
end program main
