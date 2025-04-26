! getinfo.f90
!
! Example that uses getinfo to get request information after completed transfer.
!
! Author:  Philipp Engel
! Licence: ISC
program main
    use, intrinsic :: iso_c_binding
    use, intrinsic :: iso_fortran_env, only: i8 => int64, r8 => real64
    use :: curl
    use :: curl_util
    implicit none

    character(len=*), parameter :: DEFAULT_URL = 'https://www.example.com/'

    character(len=:), allocatable :: str
    integer                       :: code, rc
    real(kind=r8)                 :: total_time
    type(c_ptr)                   :: curl_ptr

    rc = curl_global_init(CURL_GLOBAL_DEFAULT)
    curl_ptr = curl_easy_init()
    if (.not. c_associated(curl_ptr)) stop 'Error: curl_easy_init() failed'

    ! Set curl options.
    rc = curl_easy_setopt(curl_ptr, CURLOPT_URL, DEFAULT_URL)

    ! Send request.
    print '("--- Sending request ...")'
    rc = curl_easy_perform(curl_ptr)

    if (rc == CURLE_OK) then
        print '("--- Reading response info ...")'
        rc = curl_easy_getinfo(curl_ptr, CURLINFO_RESPONSE_CODE, code)
        if (rc == CURLE_OK) print '("Response Code: ", i0)', code

        rc = curl_easy_getinfo(curl_ptr, CURLINFO_CONTENT_TYPE, str)
        if (rc == CURLE_OK) print '("Content Type.: ", a)', str

        rc = curl_easy_getinfo(curl_ptr, CURLINFO_TOTAL_TIME, total_time)
        if (rc == CURLE_OK) print '("Total Time...: ", f5.3, " s")', total_time
    else
        print '("Error: ", a)', curl_easy_strerror(rc)
    end if

    ! Read response header.
    block
        character(len=:), allocatable :: name, value
        type(curl_header), pointer    :: header, prev

        header => null()
        prev   => null()

        print '("--- Reading response header ...")'
        rc = curl_easy_header(curl_ptr, 'Content-Type', 0_i8, CURLH_HEADER, -1, header)

        if (rc == CURLHE_OK) then
            call c_f_str_ptr(header%value, value)
            print '("Content Type.: ", a)', value
        else
            print '("Error: ", a)', curl_easy_strerror(rc)
        end if

        print '("--- Reading all response headers ...")'
        do
            header => curl_easy_nextheader(curl_ptr, CURLH_HEADER, -1, prev)
            if (.not. associated(header)) exit

            call c_f_str_ptr(header%name, name)
            call c_f_str_ptr(header%value, value)
            print '(a, ": ", a, " (", i0, ")")', name, value, header%amount
            prev => header
        end do
    end block

    call curl_easy_cleanup(curl_ptr)
    call curl_global_cleanup()
end program main
