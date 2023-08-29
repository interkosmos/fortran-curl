! download.f90
!
! Downloads a remote file, using libcurl.
!
! Author:  Philipp Engel
! Licence: ISC
module download_callback
    use, intrinsic :: iso_fortran_env, only: i8 => int64
    use :: curl, only: c_f_str_ptr
    implicit none
    private
    public :: response_callback
contains
    ! static size_t callback(char *ptr, size_t size, size_t nmemb, void *data)
    function response_callback(ptr, size, nmemb, data) bind(c)
        !! Callback function for `CURLOPT_WRITEFUNCTION` that appends the
        !! response chunk in `ptr` to the given file with file name in pointer
        !! `data`.
        !!
        !! This callback function might be called several times by libcurl,
        !! passing in more chunks of the response.
        use, intrinsic :: iso_c_binding, only: c_associated, c_f_pointer, c_ptr, c_size_t
        type(c_ptr),            intent(in), value :: ptr               !! C pointer to a chunk of the response.
        integer(kind=c_size_t), intent(in), value :: size              !! Always 1.
        integer(kind=c_size_t), intent(in), value :: nmemb             !! Size of the response chunk.
        type(c_ptr),            intent(in), value :: data              !! C pointer to argument passed by caller.
        integer(kind=c_size_t)                    :: response_callback !! Function return value.

        character(len=32), pointer    :: file_name ! File to store response to.
        character(len=:), allocatable :: chunk     ! Response chunk.
        integer(kind=i8)              :: fu, rc

        response_callback = int(0, kind=c_size_t)

        if (.not. c_associated(ptr)) return
        if (.not. c_associated(data)) return

        call c_f_pointer(data, file_name)
        if (len_trim(file_name) == 0) return
        call c_f_str_ptr(ptr, chunk, int(nmemb, kind=i8))

        open (access   = 'stream', &
              action   = 'write', &
              file     = trim(file_name), &
              form     = 'unformatted', &
              iostat   = rc, &
              newunit  = fu, &
              position = 'append', &
              status   = 'unknown')
        if (rc /= 0) return
        write (fu, iostat=rc) chunk
        close (fu)
        if (rc /= 0) return

        response_callback = nmemb
    end function response_callback
end module download_callback

program main
    use, intrinsic :: iso_c_binding
    use :: curl
    use :: download_callback
    implicit none

    character(len=*), parameter :: DEFAULT_PROTOCOL = 'http'
    character(len=*), parameter :: DEFAULT_URL      = 'https://netlib.org/fftpack/test.f'

    character(len=32), target :: file_name = 'data.txt'
    integer                   :: rc
    logical                   :: file_exists
    type(c_ptr)               :: curl_ptr

    inquire (file=trim(file_name), exist=file_exists)

    if (file_exists) then
        print '(3a)', 'Local file "', trim(file_name), '" already exists'
        stop
    end if

    rc = curl_global_init(CURL_GLOBAL_DEFAULT)
    curl_ptr = curl_easy_init()

    if (.not. c_associated(curl_ptr)) then
        stop 'Error: curl_easy_init() failed'
    end if

    ! Set curl options.
    rc = curl_easy_setopt(curl_ptr, CURLOPT_DEFAULT_PROTOCOL, DEFAULT_PROTOCOL)
    rc = curl_easy_setopt(curl_ptr, CURLOPT_URL,              DEFAULT_URL)
    rc = curl_easy_setopt(curl_ptr, CURLOPT_FOLLOWLOCATION,   1)
    rc = curl_easy_setopt(curl_ptr, CURLOPT_TIMEOUT,          10)
    rc = curl_easy_setopt(curl_ptr, CURLOPT_NOSIGNAL,         1)
    rc = curl_easy_setopt(curl_ptr, CURLOPT_CONNECTTIMEOUT,   10)
    rc = curl_easy_setopt(curl_ptr, CURLOPT_WRITEFUNCTION,    c_funloc(response_callback))
    rc = curl_easy_setopt(curl_ptr, CURLOPT_WRITEDATA,        c_loc(file_name))

    print '("Saving ", a, " to file ", a, " ...")', DEFAULT_URL, trim(file_name)

    ! Send request.
    if (curl_easy_perform(curl_ptr) /= CURLE_OK) then
        print '("Error: curl_easy_perform() failed")'
    else
        print '("Done.")'
    end if

    call curl_easy_cleanup(curl_ptr)
    call curl_global_cleanup()
end program main
