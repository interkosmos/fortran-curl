! curl.f90
!
! Wrapper for the libcurl interface modules.
!
! Author:  Philipp Engel
! Licence: ISC
module curl
    use :: curl_easy
    use :: curl_multi
    use :: curl_urlapi
    use :: curl_util
    implicit none
end module curl
