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
    character(len=:), allocatable         :: host, str, vcurl, vssl
    type(curl_version_info_data), pointer :: data

    data => curl_version_info(curl_version_now())

    call c_f_str_ptr(data%host,        host)
    call c_f_str_ptr(data%version,     vcurl)
    call c_f_str_ptr(data%ssl_version, vssl)

    print '("Host: ", a)', trim(host)
    print '("cURL: ", a)', trim(vcurl)
    print '("SSL:  ", a)', trim(vssl)

    str = 'escaped string &'
    print '(/, "Escaped: ", a)', curl_escape(str)
end program main
