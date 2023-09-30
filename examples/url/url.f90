! url.f90
!
! Example that demonstrates the URL API of libcurl.
!
! Author:  Philipp Engel
! Licence: ISC
program main
    use, intrinsic :: iso_c_binding
    use :: curl
    implicit none

    character(len=*), parameter :: URL = 'https://user:secret@example.com:449/foo/bar?name=moo'

    character(len=:), allocatable :: fragment, host, password, path, port, &
                                     query, scheme, user, zone_id
    integer     :: rc
    type(c_ptr) :: h

    h = curl_url()
    if (.not. c_associated(h)) stop 'Error: curl_url() failed'

    rc = curl_url_set(h, CURLUPART_URL, URL)

    rc = curl_url_get(h, CURLUPART_FRAGMENT, fragment)
    rc = curl_url_get(h, CURLUPART_HOST, host)
    rc = curl_url_get(h, CURLUPART_PASSWORD, password)
    rc = curl_url_get(h, CURLUPART_PATH, path)
    rc = curl_url_get(h, CURLUPART_PORT, port)
    rc = curl_url_get(h, CURLUPART_QUERY, query)
    rc = curl_url_get(h, CURLUPART_SCHEME, scheme)
    rc = curl_url_get(h, CURLUPART_USER, user)
    rc = curl_url_get(h, CURLUPART_ZONEID, zone_id)

    print '("Fragment: ", a)', fragment
    print '("Host....: ", a)', host
    print '("Password: ", a)', password
    print '("Path....: ", a)', path
    print '("Port....: ", a)', port
    print '("Query...: ", a)', query
    print '("Scheme..: ", a)', scheme
    print '("URL.....: ", a)', URL
    print '("User....: ", a)', user
    print '("Zone ID.: ", a)', zone_id

    call curl_url_cleanup(h)
end program main
