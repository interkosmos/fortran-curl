! multi.f90
!
! Example that calls the multi interface of libcurl to make two parallel HTTP
! transfers.
!
! Author:  Philipp Engel
! Licence: ISC
program main
    use, intrinsic :: iso_c_binding
    use :: curl
    implicit none

    integer, parameter :: NHANDLES = 2

    integer :: nfds, queued, still_running
    integer :: i, idx, mc, rc

    type(c_ptr) :: http_handles(NHANDLES)
    type(c_ptr) :: multi_handle
    type(c_ptr) :: msg_ptr

    type(curl_msg), pointer :: msg

    still_running = 1

    ! Init libcurl.
    rc = curl_global_init(CURL_GLOBAL_DEFAULT)

    ! Init easy stacks.
    do i = 1, NHANDLES
        http_handles(i) = curl_easy_init()
    end do

    ! Set curl options.
    rc = curl_easy_setopt(http_handles(1), CURLOPT_URL, 'https://www.netlib.org/slatec/readme')
    rc = curl_easy_setopt(http_handles(2), CURLOPT_URL, 'https://www.netlib.org/linpack/readme')

    ! Init the multi stack.
    multi_handle = curl_multi_init()

    ! Add the individual transfers.
    do i = 1, NHANDLES
        rc = curl_multi_add_handle(multi_handle, http_handles(i))
    end do

    do while (still_running > 0)
        mc = curl_multi_perform(multi_handle, still_running)

        if (still_running > 0) then
            ! Wait for activity, timeout, or "nothing".
            nfds = 0
            mc = curl_multi_poll(multi_handle, c_null_ptr, 0, 1000, nfds)
        end if

        if (mc /= CURLM_OK) exit
    end do

    ! See how the transfers went.
    do
        msg_ptr = curl_multi_info_read(multi_handle, queued)
        if (.not. c_associated(msg_ptr)) exit
        call c_f_pointer(msg_ptr, msg)
        if (msg%msg /= CURLMSG_DONE) cycle

        idx = 0

        ! Find out which handle this message is about.
        do i = 1, NHANDLES
            if (c_associated(msg%easy_handle, http_handles(i))) then
                idx = i
                exit
            end if
        end do

        if (idx == 0) cycle
        print '("HTTP transfer ", i0, " completed with cURL status ", i0)', idx, msg%result
    end do

    ! Clean-up all resources.
    do i = 1, NHANDLES
        rc = curl_multi_remove_handle(multi_handle, http_handles(i))
        call curl_easy_cleanup(http_handles(i))
    end do

    rc = curl_multi_cleanup(multi_handle)
    call curl_global_cleanup()
end program main
