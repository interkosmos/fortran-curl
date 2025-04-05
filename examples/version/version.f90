! version.f90
!
! Example that outputs cURL version information.
!
! Author:  Philipp Engel
! Licence: ISC
program main
    use, intrinsic :: iso_c_binding
    use :: curl
    implicit none
    integer                               :: rc
    character(len=:), allocatable         :: host, vcurl, vssl
    character(len=:), allocatable         :: str, escaped, unescaped
    type(c_ptr)                           :: curl_ptr
    type(curl_version_info_data), pointer :: data

    rc = curl_global_init(CURL_GLOBAL_DEFAULT)

    print '("Version: ", a, /)', curl_version()

    data => curl_version_info(curl_version_now())

    call c_f_str_ptr(data%host,        host)
    call c_f_str_ptr(data%version,     vcurl)
    call c_f_str_ptr(data%ssl_version, vssl)

    print '("Host: ", a)', trim(host)
    print '("cURL: ", a)', trim(vcurl)
    print '("SSL:  ", a)', trim(vssl)

    str       = 'escaped string &'
    escaped   = curl_escape(str)
    unescaped = curl_unescape(escaped)

    print '(/, "Escaped:   ", a)', escaped
    print '("Unescaped: ", a)',    unescaped

    curl_ptr = curl_easy_init()
    if (.not. c_associated(curl_ptr)) print '("Error: curl_easy_init() failed")'

    call curl_easy_cleanup(curl_ptr)
    if (c_associated(curl_ptr)) print '("Error: failed to free context (possible compiler bug)")'

    call curl_global_cleanup()
end program main
