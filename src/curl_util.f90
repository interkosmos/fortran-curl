! curl_util.f90
!
! Utility procedures for C interoperability.
!
! Author:  Philipp Engel
! Licence: ISC
module curl_util
    use, intrinsic :: iso_c_binding
    use, intrinsic :: iso_fortran_env, only: i8 => int64
    implicit none
    private

    integer, parameter, public :: c_unsigned_int = c_int

    interface
        ! size_t strlen(const char *str)
        function c_strlen(str) bind(c, name='strlen')
            import :: c_ptr, c_size_t
            implicit none
            type(c_ptr), intent(in), value :: str
            integer(kind=c_size_t)         :: c_strlen
        end function c_strlen
    end interface

    public :: c_f_str_ptr
contains
    subroutine c_f_str_ptr(c_str, f_str, size)
        !! Copies a C string, passed as a C pointer, to a Fortran string.
        type(c_ptr),                   intent(in)           :: c_str
        character(len=:), allocatable, intent(out)          :: f_str
        integer(kind=i8),              intent(in), optional :: size

        character(kind=c_char), pointer :: ptrs(:)
        integer(kind=i8)                :: i, sz

        copy_if: if (c_associated(c_str)) then
            if (present(size)) then
                sz = size
            else
                sz = c_strlen(c_str)
            end if

            if (sz < 0) exit copy_if
            call c_f_pointer(c_str, ptrs, [ sz ])
            allocate (character(len=sz) :: f_str)

            do i = 1, sz
                f_str(i:i) = ptrs(i)
            end do

            return
        end if copy_if

        if (.not. allocated(f_str)) f_str = ''
    end subroutine c_f_str_ptr
end module curl_util
