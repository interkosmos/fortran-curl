! curl_urlapi.f90
!
! Fortran 2008 ISO C binding interfaces to `urlapi.h`.
!
! Author:  Philipp Engel
! Licence: ISC
module curl_urlapi
    use :: curl_easy
    use :: curl_util
    implicit none
    private

    ! CURLUcode
    integer(c_int), parameter, public :: CURLUE_OK                 = 0
    integer(c_int), parameter, public :: CURLUE_BAD_HANDLE         = 1
    integer(c_int), parameter, public :: CURLUE_BAD_PARTPOINTER    = 2
    integer(c_int), parameter, public :: CURLUE_MALFORMED_INPUT    = 3
    integer(c_int), parameter, public :: CURLUE_BAD_PORT_NUMBER    = 4
    integer(c_int), parameter, public :: CURLUE_UNSUPPORTED_SCHEME = 5
    integer(c_int), parameter, public :: CURLUE_URLDECODE          = 6
    integer(c_int), parameter, public :: CURLUE_OUT_OF_MEMORY      = 7
    integer(c_int), parameter, public :: CURLUE_USER_NOT_ALLOWED   = 8
    integer(c_int), parameter, public :: CURLUE_UNKNOWN_PART       = 9
    integer(c_int), parameter, public :: CURLUE_NO_SCHEME          = 10
    integer(c_int), parameter, public :: CURLUE_NO_USER            = 11
    integer(c_int), parameter, public :: CURLUE_NO_PASSWORD        = 12
    integer(c_int), parameter, public :: CURLUE_NO_OPTIONS         = 13
    integer(c_int), parameter, public :: CURLUE_NO_HOST            = 14
    integer(c_int), parameter, public :: CURLUE_NO_PORT            = 15
    integer(c_int), parameter, public :: CURLUE_NO_QUERY           = 16
    integer(c_int), parameter, public :: CURLUE_NO_FRAGMENT        = 17
    integer(c_int), parameter, public :: CURLUE_NO_ZONEID          = 18
    integer(c_int), parameter, public :: CURLUE_BAD_FILE_URL       = 19
    integer(c_int), parameter, public :: CURLUE_BAD_FRAGMENT       = 20
    integer(c_int), parameter, public :: CURLUE_BAD_HOSTNAME       = 21
    integer(c_int), parameter, public :: CURLUE_BAD_IPV6           = 22
    integer(c_int), parameter, public :: CURLUE_BAD_LOGIN          = 23
    integer(c_int), parameter, public :: CURLUE_BAD_PASSWORD       = 24
    integer(c_int), parameter, public :: CURLUE_BAD_PATH           = 25
    integer(c_int), parameter, public :: CURLUE_BAD_QUERY          = 26
    integer(c_int), parameter, public :: CURLUE_BAD_SCHEME         = 27
    integer(c_int), parameter, public :: CURLUE_BAD_SLASHES        = 28
    integer(c_int), parameter, public :: CURLUE_BAD_USER           = 29
    integer(c_int), parameter, public :: CURLUE_LACKS_IDN          = 30
    integer(c_int), parameter, public :: CURLUE_TOO_LARGE          = 31
    integer(c_int), parameter, public :: CURLUE_LAST               = 32

    ! CURLUPart
    integer(c_int), parameter, public :: CURLUPART_URL      = 0
    integer(c_int), parameter, public :: CURLUPART_SCHEME   = 1
    integer(c_int), parameter, public :: CURLUPART_USER     = 2
    integer(c_int), parameter, public :: CURLUPART_PASSWORD = 3
    integer(c_int), parameter, public :: CURLUPART_OPTIONS  = 4
    integer(c_int), parameter, public :: CURLUPART_HOST     = 5
    integer(c_int), parameter, public :: CURLUPART_PORT     = 6
    integer(c_int), parameter, public :: CURLUPART_PATH     = 7
    integer(c_int), parameter, public :: CURLUPART_QUERY    = 8
    integer(c_int), parameter, public :: CURLUPART_FRAGMENT = 9
    integer(c_int), parameter, public :: CURLUPART_ZONEID   = 10

    integer(c_int), parameter, public :: CURLU_DEFAULT_PORT       = shiftl(1,  0)
    integer(c_int), parameter, public :: CURLU_NO_DEFAULT_PORT    = shiftl(1,  1)
    integer(c_int), parameter, public :: CURLU_DEFAULT_SCHEME     = shiftl(1,  2)
    integer(c_int), parameter, public :: CURLU_NON_SUPPORT_SCHEME = shiftl(1,  3)
    integer(c_int), parameter, public :: CURLU_PATH_AS_IS         = shiftl(1,  4)
    integer(c_int), parameter, public :: CURLU_DISALLOW_USER      = shiftl(1,  5)
    integer(c_int), parameter, public :: CURLU_URLDECODE          = shiftl(1,  6)
    integer(c_int), parameter, public :: CURLU_URLENCODE          = shiftl(1,  7)
    integer(c_int), parameter, public :: CURLU_APPENDQUERY        = shiftl(1,  8)
    integer(c_int), parameter, public :: CURLU_GUESS_SCHEME       = shiftl(1,  9)
    integer(c_int), parameter, public :: CURLU_NO_AUTHORITY       = shiftl(1, 10)
    integer(c_int), parameter, public :: CURLU_ALLOW_SPACE        = shiftl(1, 11)
    integer(c_int), parameter, public :: CURLU_PUNYCODE           = shiftl(1, 12)
    integer(c_int), parameter, public :: CURLU_PUNY2IDN           = shiftl(1, 13)

    public :: curl_url
    public :: curl_url_cleanup
    public :: curl_url_dup
    public :: curl_url_get
    public :: curl_url_set
    public :: curl_url_strerror

    interface
        ! CURLU *curl_url(void)
        function curl_url() bind(c, name='curl_url')
            import :: c_ptr
            implicit none
            type(c_ptr) :: curl_url
        end function curl_url

        ! CURLU *curl_url_dup(const CURLU *in)
        function curl_url_dup(in) bind(c, name='curl_url_dup')
            import :: c_ptr
            implicit none
            type(c_ptr), intent(in), value :: in
            type(c_ptr)                    :: curl_url_dup
        end function curl_url_dup

        ! CURLUcode curl_url_get(const CURLU *url, CURLUPart what, char **part, unsigned int flags)
        function curl_url_get_(url, what, part, flags) bind(c, name='curl_url_get')
            import :: c_int, c_ptr, c_unsigned
            implicit none
            type(c_ptr),         intent(in), value :: url
            integer(c_int),      intent(in), value :: what
            type(c_ptr),         intent(out)       :: part
            integer(c_unsigned), intent(in), value :: flags
            integer(c_int)                         :: curl_url_get_
        end function curl_url_get_

        ! CURLUcode curl_url_set(CURLU *url, CURLUPart what, const char *part, unsigned int flags)
        function curl_url_set_(url, what, part, flags) bind(c, name='curl_url_set')
            import :: c_char, c_int, c_ptr, c_unsigned
            implicit none
            type(c_ptr),         intent(in), value :: url
            integer(c_int),      intent(in), value :: what
            character(c_char),   intent(in)        :: part
            integer(c_unsigned), intent(in), value :: flags
            integer(c_int)                         :: curl_url_set_
        end function curl_url_set_

        ! const char *curl_url_strerror(CURLMcode code)
        function curl_url_strerror_(code) bind(c, name='curl_url_strerror')
            import :: c_int, c_ptr
            implicit none
            integer(c_int), intent(in), value :: code
            type(c_ptr)                       :: curl_url_strerror_
        end function curl_url_strerror_

        ! void curl_url_cleanup_(CURLU **url)
        subroutine curl_url_cleanup(url) bind(c, name='curl_url_cleanup_')
            import :: c_ptr
            implicit none
            type(c_ptr), intent(inout) :: url
        end subroutine curl_url_cleanup
    end interface
contains
    ! CURLUcode curl_url_get(const CURLU *url, CURLUPart what, char **part, unsigned int flags)
    function curl_url_get(url, what, part, flags) result(rc)
        type(c_ptr),               intent(inout)        :: url
        integer,                   intent(in)           :: what
        character(:), allocatable, intent(out)          :: part
        integer,                   intent(in), optional :: flags
        integer                                         :: rc

        integer     :: flags_
        type(c_ptr) :: ptr

        flags_ = 0
        if (present(flags)) flags_ = flags
        rc = curl_url_get_(url, what, ptr, flags_)
        call c_f_str_ptr(ptr, part)
        call curl_free(ptr)
    end function curl_url_get

    ! CURLUcode curl_url_set(CURLU *url, CURLUPart what, const char *part, unsigned int flags)
    function curl_url_set(url, what, part, flags) result(rc)
        type(c_ptr),  intent(inout)        :: url
        integer,      intent(in)           :: what
        character(*), intent(in)           :: part
        integer,      intent(in), optional :: flags
        integer                            :: rc

        integer :: flags_

        flags_ = 0
        if (present(flags)) flags_ = flags
        rc = curl_url_set_(url, what, f_c_str(part), flags_)
    end function curl_url_set

    ! const char *curl_url_strerror(CURLMcode code)
    function curl_url_strerror(code) result(str)
        integer, intent(in)       :: code
        character(:), allocatable :: str

        type(c_ptr) :: ptr

        ptr = curl_url_strerror_(code)
        call c_f_str_ptr(ptr, str)
    end function curl_url_strerror
end module curl_urlapi
