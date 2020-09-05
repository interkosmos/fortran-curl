! version.f90
!
! Example that outputs cURL version information.
!
! Author:  Philipp Engel
! Licence: ISC
program main
    use, intrinsic :: iso_c_binding
    use :: curl
    use :: callback
    implicit none
    character(len=64)           :: host, vcurl, vssl
    type(curl_version), pointer :: data

    data => curl_version_info(curl_version_now())

    call c_f_str_ptr(data%host,        host)
    call c_f_str_ptr(data%version,     vcurl)
    call c_f_str_ptr(data%ssl_version, vssl)

    print '(2a)', 'Host: ', trim(host)
    print '(2a)', 'cURL: ', trim(vcurl)
    print '(2a)', 'SSL : ', trim(vssl)
end program main
