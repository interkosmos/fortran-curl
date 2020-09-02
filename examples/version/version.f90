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
contains
    subroutine c_f_str_ptr(c_str, f_str)
        !! Utility routine that copies a C string, passed as a C pointer, to a
        !! Fortran string.
        use, intrinsic :: iso_c_binding, only: c_associated, c_char, c_f_pointer, c_null_char, c_ptr
        type(c_ptr),      intent(in)           :: c_str
        character(len=*), intent(out)          :: f_str
        character(kind=c_char, len=1), pointer :: chars(:)
        integer                                :: i

        if (.not. c_associated(c_str)) then
            f_str = ' '
            return
        end if

        call c_f_pointer(c_str, chars, [ huge(0) ])
        i = 1

        do while (chars(i) /= c_null_char .and. i <= len(f_str))
            f_str(i:i) = chars(i)
            i = i + 1
        end do

        if (i < len(f_str)) f_str(i:) = ' '
    end subroutine c_f_str_ptr
end program main
