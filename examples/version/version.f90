! version.f90
!
! Example that outputs cURL version information.
!
! Author:  Philipp Engel
! Licence: ISC
program main
    use :: curl
    implicit none
    character(len=:), allocatable :: host, vcurl, vssl
    character(len=:), allocatable :: str, escaped, unescaped

    type(curl_version_info_data), pointer :: data

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
end program main
