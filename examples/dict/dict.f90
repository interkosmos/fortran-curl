! dict.f90
!
! Basic dict protocol example, that looks up the definitions of the given words in
! the dictionaries at dict://dict.org/ on port 2628. The program is equal to
! running
!
!   $ curl dict://dict.org/d:FORTRAN
!
! on the command-line.
!
! Author:  John S. Urban, Philipp Engel
! Licence: ISC
module callback_dict
    use :: curl, only: c_f_str_ptr
    implicit none
    private
    public :: response_callback
contains
    ! static size_t callback(char *ptr, size_t size, size_t nmemb, void *data)
    function response_callback(ptr, size, nmemb, data) bind(c)
        !! Callback function for `CURLOPT_WRITEFUNCTION` that prints the
        !! response to standard output.
        !!
        !! This callback function might be called several times by libcurl,
        !! passing in more chunks of the response.
        use, intrinsic :: iso_c_binding, only: c_associated, c_f_pointer, c_ptr, c_size_t
        type(c_ptr),            intent(in), value :: ptr               !! C pointer to a chunk of the response.
        integer(kind=c_size_t), intent(in), value :: size              !! Always 1.
        integer(kind=c_size_t), intent(in), value :: nmemb             !! Size of the response chunk.
        type(c_ptr),            intent(in), value :: data              !! C pointer to argument passed by caller.
        integer(kind=c_size_t)                    :: response_callback !! Function return value.
        character(len=:), allocatable             :: response

        response_callback = int(0, kind=c_size_t)

        if (.not. c_associated(ptr)) return

        allocate (character(len=nmemb) :: response)
        call c_f_str_ptr(ptr, response)
        write (*, '(a)', advance='no') response
        deallocate (response)

        response_callback = nmemb
    end function response_callback
end module callback_dict

program main
    use, intrinsic :: iso_c_binding
    use :: curl
    use :: callback_dict
    implicit none

    character(len=*), parameter :: DEFAULT_PROTOCOL = 'dict'
    character(len=*), parameter :: DEFAULT_URL      = 'dict://dict.org/'
    character(len=*), parameter :: DICT_QUERY       = 'd:FORTRAN'
    type(c_ptr)                 :: curl_ptr
    integer                     :: rc

    curl_ptr = curl_easy_init()

    if (.not. c_associated(curl_ptr)) then
        stop 'Error: curl_easy_init() failed'
    end if

    ! Set curl options.
    rc = curl_easy_setopt(curl_ptr, CURLOPT_DEFAULT_PROTOCOL, DEFAULT_PROTOCOL // c_null_char)
    rc = curl_easy_setopt(curl_ptr, CURLOPT_URL,              DEFAULT_URL // DICT_QUERY // c_null_char)
    rc = curl_easy_setopt(curl_ptr, CURLOPT_TIMEOUT,          int(10, kind=8))
    rc = curl_easy_setopt(curl_ptr, CURLOPT_NOSIGNAL,         int( 1, kind=8))
    rc = curl_easy_setopt(curl_ptr, CURLOPT_CONNECTTIMEOUT,   int(10, kind=8))
    rc = curl_easy_setopt(curl_ptr, CURLOPT_WRITEFUNCTION,    c_funloc(response_callback))

    ! Send request.
    if (curl_easy_perform(curl_ptr) /= CURLE_OK) then
        print '(a)', 'Error: curl_easy_perform() failed'
    end if

    call curl_easy_cleanup(curl_ptr)
end program main
