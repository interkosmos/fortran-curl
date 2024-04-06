! curl_multi.f90
!
! Fortran 2008 ISO C binding interfaces to `multi.h`.
!
! Author:  Philipp Engel
! Licence: ISC
module curl_multi
    use, intrinsic :: iso_c_binding
    use :: curl_easy
    use :: curl_util
    implicit none
    private

    ! CURLMoption
    integer(kind=c_int), parameter, public :: CURLMOPT_SOCKETFUNCTION              = CURLOPTTYPE_FUNCTIONPOINT + 1
    integer(kind=c_int), parameter, public :: CURLMOPT_SOCKETDATA                  = CURLOPTTYPE_OBJECTPOINT + 2
    integer(kind=c_int), parameter, public :: CURLMOPT_PIPELINING                  = CURLOPTTYPE_LONG + 3
    integer(kind=c_int), parameter, public :: CURLMOPT_TIMERFUNCTION               = CURLOPTTYPE_FUNCTIONPOINT + 4
    integer(kind=c_int), parameter, public :: CURLMOPT_TIMERDATA                   = CURLOPTTYPE_OBJECTPOINT + 5
    integer(kind=c_int), parameter, public :: CURLMOPT_MAXCONNECTS                 = CURLOPTTYPE_LONG + 6
    integer(kind=c_int), parameter, public :: CURLMOPT_MAX_HOST_CONNECTIONS        = CURLOPTTYPE_LONG + 7
    integer(kind=c_int), parameter, public :: CURLMOPT_MAX_PIPELINE_LENGTH         = CURLOPTTYPE_LONG + 8
    integer(kind=c_int), parameter, public :: CURLMOPT_CONTENT_LENGTH_PENALTY_SIZE = CURLOPTTYPE_OFF_T + 9
    integer(kind=c_int), parameter, public :: CURLMOPT_CHUNK_LENGTH_PENALTY_SIZE   = CURLOPTTYPE_OFF_T + 10
    integer(kind=c_int), parameter, public :: CURLMOPT_PIPELINING_SITE_BL          = CURLOPTTYPE_OBJECTPOINT + 11
    integer(kind=c_int), parameter, public :: CURLMOPT_PIPELINING_SERVER_BL        = CURLOPTTYPE_OBJECTPOINT + 12
    integer(kind=c_int), parameter, public :: CURLMOPT_MAX_TOTAL_CONNECTIONS       = CURLOPTTYPE_LONG + 13
    integer(kind=c_int), parameter, public :: CURLMOPT_PUSHFUNCTION                = CURLOPTTYPE_FUNCTIONPOINT + 14
    integer(kind=c_int), parameter, public :: CURLMOPT_PUSHDATA                    = CURLOPTTYPE_OBJECTPOINT + 15
    integer(kind=c_int), parameter, public :: CURLMOPT_MAX_CONCURRENT_STREAMS      = CURLOPTTYPE_LONG + 16

    ! CURLMcode
    integer(kind=c_int), parameter, public :: CURLM_CALL_MULTI_PERFORM    = -1
    integer(kind=c_int), parameter, public :: CURLM_OK                    = 0
    integer(kind=c_int), parameter, public :: CURLM_BAD_HANDLE            = 1
    integer(kind=c_int), parameter, public :: CURLM_BAD_EASY_HANDLE       = 2
    integer(kind=c_int), parameter, public :: CURLM_OUT_OF_MEMORY         = 3
    integer(kind=c_int), parameter, public :: CURLM_INTERNAL_ERROR        = 4
    integer(kind=c_int), parameter, public :: CURLM_BAD_SOCKET            = 5
    integer(kind=c_int), parameter, public :: CURLM_UNKNOWN_OPTION        = 6
    integer(kind=c_int), parameter, public :: CURLM_ADDED_ALREADY         = 7
    integer(kind=c_int), parameter, public :: CURLM_RECURSIVE_API_CALL    = 8
    integer(kind=c_int), parameter, public :: CURLM_WAKEUP_FAILURE        = 9
    integer(kind=c_int), parameter, public :: CURLM_BAD_FUNCTION_ARGUMENT = 10
    integer(kind=c_int), parameter, public :: CURLM_ABORTED_BY_CALLBACK   = 11
    integer(kind=c_int), parameter, public :: CURLM_UNRECOVERABLE_POLL    = 12
    integer(kind=c_int), parameter, public :: CURLM_LAST                  = 13

    integer(kind=c_int), parameter, public :: CURLM_CALL_MULTI_SOCKET = CURLM_CALL_MULTI_PERFORM

    ! CURLMSG
    integer(kind=c_int), parameter, public :: CURLMSG_NONE = 0
    integer(kind=c_int), parameter, public :: CURLMSG_DONE = 1
    integer(kind=c_int), parameter, public :: CURLMSG_LAST = 2

    ! CURLMsg
    type, bind(c), public :: curl_msg
        integer(kind=c_int)      :: msg         = 0          !! CURLMSG
        type(c_ptr)              :: easy_handle = c_null_ptr !! CURL
        integer(kind=c_intptr_t) :: result      = 0          !! union of `void *` and `CURLcode`
    end type curl_msg

    public :: curl_multi_add_handle
    public :: curl_multi_cleanup
    public :: curl_multi_info_read
    public :: curl_multi_init
    public :: curl_multi_perform
    public :: curl_multi_poll
    public :: curl_multi_remove_handle
    public :: curl_multi_strerror
    public :: curl_multi_timeout
    public :: curl_multi_wakeup

    interface
        ! CURLMcode curl_multi_add_handle(CURLM *multi_handle, CURL *curl_handle)
        function curl_multi_add_handle(multi_handle, curl_handle) bind(c, name='curl_multi_add_handle')
            import :: c_int, c_ptr
            implicit none
            type(c_ptr), intent(in), value :: multi_handle
            type(c_ptr), intent(in), value :: curl_handle
            integer(kind=c_int)            :: curl_multi_add_handle
        end function curl_multi_add_handle

        ! CURLMcode curl_multi_cleanup(CURLM *multi_handle)
        function curl_multi_cleanup(multi_handle) bind(c, name='curl_multi_cleanup')
            import :: c_int, c_ptr
            implicit none
            type(c_ptr), intent(in), value :: multi_handle
            integer(kind=c_int)            :: curl_multi_cleanup
        end function curl_multi_cleanup

        ! CURLMsg *curl_multi_info_read(CURLM *multi_handle, int *msgs_in_queue)
        function curl_multi_info_read(multi_handle, msgs_in_queue) bind(c, name='curl_multi_info_read')
            import :: c_int, c_ptr
            implicit none
            type(c_ptr),         intent(in), value :: multi_handle
            integer(kind=c_int), intent(out)       :: msgs_in_queue
            type(c_ptr)                            :: curl_multi_info_read
        end function curl_multi_info_read

        ! CURLM *curl_multi_init(void)
        function curl_multi_init() bind(c, name='curl_multi_init')
            import :: c_ptr
            implicit none
            type(c_ptr) :: curl_multi_init
        end function curl_multi_init

        ! CURLMcode curl_multi_perform(CURLM *multi_handle, int *running_handles)
        function curl_multi_perform(multi_handle, running_handles) bind(c, name='curl_multi_perform')
            import :: c_int, c_ptr
            implicit none
            type(c_ptr),         intent(in), value :: multi_handle
            integer(kind=c_int), intent(out)       :: running_handles
            integer(kind=c_int)                    :: curl_multi_perform
        end function curl_multi_perform

        ! CURLMcode curl_multi_poll(CURLM *multi_handle, struct curl_waitfd extra_fds[], unsigned int extra_nfds, int timeout_ms, int *num_fds)
        function curl_multi_poll(multi_handle, extra_fds, extra_nfds, timeout_ms, num_fds) bind(c, name='curl_multi_poll')
            import :: c_int, c_ptr, c_unsigned_int
            implicit none
            type(c_ptr),                  intent(in), value :: multi_handle
            type(c_ptr),                  intent(in), value :: extra_fds
            integer(kind=c_unsigned_int), intent(in), value :: extra_nfds
            integer(kind=c_int),          intent(in), value :: timeout_ms
            integer(kind=c_int),          intent(inout)     :: num_fds
            integer(kind=c_int)                             :: curl_multi_poll
        end function curl_multi_poll

        ! CURLMcode curl_multi_remove_handle(CURLM *multi_handle, CURL *curl_handle)
        function curl_multi_remove_handle(multi_handle, curl_handle) bind(c, name='curl_multi_remove_handle')
            import :: c_int, c_ptr
            implicit none
            type(c_ptr), intent(in), value :: multi_handle
            type(c_ptr), intent(in), value :: curl_handle
            integer(kind=c_int)            :: curl_multi_remove_handle
        end function curl_multi_remove_handle

        ! const char *curl_multi_strerror(CURLMcode code)
        function curl_multi_strerror_(code) bind(c, name='curl_multi_strerror')
            import :: c_int, c_ptr
            implicit none
            integer(kind=c_int), intent(in), value :: code
            type(c_ptr)                            :: curl_multi_strerror_
        end function curl_multi_strerror_

        ! CURLMcode curl_multi_timeout(CURLM *multi_handle, long *milliseconds)
        function curl_multi_timeout(multi_handle, milliseconds) bind(c, name='curl_multi_timeout')
            import :: c_int, c_long, c_ptr
            implicit none
            type(c_ptr),          intent(in), value :: multi_handle
            integer(kind=c_long), intent(in)        :: milliseconds
            integer(kind=c_int)                     :: curl_multi_timeout
        end function curl_multi_timeout

        ! CURLMcode curl_multi_wakeup(CURLM *multi_handle)
        function curl_multi_wakeup(multi_handle) bind(c, name='curl_multi_wakeup')
            import :: c_int, c_ptr
            implicit none
            type(c_ptr), intent(in), value :: multi_handle
            integer(kind=c_int)            :: curl_multi_wakeup
        end function curl_multi_wakeup
    end interface
contains
    ! const char *curl_multi_strerror(CURLMcode code)
    function curl_multi_strerror(code) result(str)
        integer, intent(in)           :: code
        character(len=:), allocatable :: str

        type(c_ptr) :: ptr

        ptr = curl_multi_strerror_(code)
        call c_f_str_ptr(ptr, str)
    end function curl_multi_strerror
end module curl_multi
