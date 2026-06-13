! curl_util.f90
!
! Utility procedures for C interoperability.
!
! Author:  Philipp Engel
! Licence: ISC
module curl_util
    use, intrinsic :: iso_c_binding, only: c_associated, c_f_pointer, c_loc, &
                                           c_char, c_double, c_int, c_intptr_t, c_long, c_size_t, &
                                           c_funptr, c_ptr, c_null_char, c_null_ptr
#if HAS_UNSIGNED
    use, intrinsic :: iso_c_binding, only: c_unsigned
#endif
    use, intrinsic :: iso_fortran_env, only: i4 => int32, i8 => int64
    implicit none
    private

#if HAS_UNSIGNED
    public :: c_unsigned
#else
    integer, parameter, public :: c_unsigned = c_int
#endif

    public :: c_associated
    public :: c_f_pointer
    public :: c_loc

    public :: c_char
    public :: c_double
    public :: c_int
    public :: c_intptr_t
    public :: c_long
    public :: c_size_t

    public :: c_funptr
    public :: c_ptr

    public :: c_null_char
    public :: c_null_ptr

    public :: c_f_str_ptr
    public :: f_c_str
contains
    subroutine c_f_str_ptr(c, f, len)
        !! Copies a C string, passed as a C pointer, to a Fortran string.
        type(c_ptr),               intent(in)           :: c   !! C string pointer.
        character(:), allocatable, intent(out)          :: f   !! Fortran string.
        integer(i8),               intent(in), optional :: len !! Optional string length.

        integer(i8) :: n

        interface
            function c_strlen(str) bind(c, name='strlen')
                import :: c_ptr, c_size_t
                implicit none
                type(c_ptr), intent(in), value :: str
                integer(c_size_t)              :: c_strlen
            end function c_strlen
        end interface

        copy_block: block
            if (.not. c_associated(c)) exit copy_block

            if (present(len)) then
                n = len
            else
                n = c_strlen(c)
            end if

            if (n <= 0) exit copy_block

            block
                character(n), pointer :: ptr
                call c_f_pointer(c, ptr)
                f = ptr
            end block

            return
        end block copy_block

        if (.not. allocated(f)) f = ''
    end subroutine c_f_str_ptr

    pure function f_c_str(f) result(c)
        !! Converts Fortran string to C string. In Fortran 2023, use
        !! `f_c_string()` instead.
        character(*), intent(in)   :: f !! Fortran string.
        character(len_trim(f) + 1) :: c !! Null-terminated C string.

        c = trim(f) // c_null_char
    end function f_c_str
end module curl_util
