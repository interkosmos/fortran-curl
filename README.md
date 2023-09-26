# fortran-curl

A collection of ISO C binding interfaces to
[libcurl](https://curl.haxx.se/libcurl/) for Fortran 2008. Compilation has been
tested with GNU Fortran 13 and cURL 8.3. The library is also available on
[MacPorts](https://ports.macports.org/port/fortran-curl/).

For a user-friendly, high-level HTTP library based on these bindings, see
[http-client](https://github.com/fortran-lang/http-client).

## Build Instructions

Install libcurl with development headers. On FreeBSD, run:

```
# pkg install ftp/curl
```

On Debian, instead:

```
# apt-get install libcurl4 libcurl4-openssl-dev
```

Clone the repository, and then run `make` to build the interfaces:

```
$ git clone https://github.com/interkosmos/fortran-curl
$ cd fortran-curl/
$ make
```

You can override the default compiler by passing the `FC` argument, for example:

```
$ make FC=ifort
```

On Linux, you may want to change the prefix to `/usr`:

```
$ make PREFIX=/usr
```

Link your Fortran application with `libfortran-curl.a -lcurl`.

## Examples

Examples are provided in directory `examples/`:

* **dict** queries a [DICT](https://en.wikipedia.org/wiki/DICT) server on TCP port 2628.
* **download** fetches a remote file.
* **getinfo** prints request-related information to console.
* **gopher** prints the contents of a remote Gopher map file.
* **http** makes an HTTP GET request.
* **imap** examines the `INBOX` of an IMAP mailbox (SSL).
* **multi** makes multiple HTTP requests at once.
* **post** makes an HTTP POST request.
* **smtp** sends an e-mail via SMTP (SSL).
* **version** outputs cURL version information.

Build an example with:

```
$ make <name>
```

Buld all by running `make examples`.

## Coverage

| C Function Name            | Fortran Interface Name                   | Bound |
|----------------------------|------------------------------------------|-------|
| `curl_easy_cleanup`        | `curl_easy_cleanup`                      | ✓     |
| `curl_easy_duphandle`      |                                          |       |
| `curl_easy_escape`         | `curl_easy_escape`                       | ✓     |
| `curl_easy_getinfo`        | `curl_easy_getinfo`                      | ✓     |
| `curl_easy_init`           | `curl_easy_init`                         | ✓     |
| `curl_easy_pause`          | `curl_easy_pause`                        | ✓     |
| `curl_easy_perform`        | `curl_easy_perform`                      | ✓     |
| `curl_easy_reset`          |                                          |       |
| `curl_easy_setopt`         | `curl_easy_setopt`, `curl_easy_setopt_*` | ✓     |
| `curl_easy_strerror`       | `curl_easy_strerror`                     | ✓     |
| `curl_easy_unescape`       | `curl_easy_unescape`                     | ✓     |
| `curl_escape`              | `curl_escape`                            | ✓     |
| `curl_formadd`             |                                          |       |
| `curl_free`                |                                          |       |
| `curl_getdate`             |                                          |       |
| `curl_getenv`              |                                          |       |
| `curl_global_cleanup`      | `curl_global_cleanup`                    | ✓     |
| `curl_global_init`         | `curl_global_init`                       | ✓     |
| `curl_global_init_mem`     |                                          |       |
| `curl_global_sslset`       |                                          |       |
| `curl_global_trace`        |                                          |       |
| `curl_mime_addpart`        | `curl_mime_addpart`                      | ✓     |
| `curl_mime_data`           | `curl_mime_data`                         | ✓     |
| `curl_mime_data_cb`        |                                          |       |
| `curl_mime_encoder`        | `curl_mime_encoder`                      | ✓     |
| `curl_mime_filedata`       | `curl_mime_filedata`                     | ✓     |
| `curl_mime_filename`       | `curl_mime_filename`                     | ✓     |
| `curl_mime_free`           | `curl_mime_free`                         | ✓     |
| `curl_mime_headers`        | `curl_mime_headers`                      | ✓     |
| `curl_mime_init`           | `curl_mime_init`                         | ✓     |
| `curl_mime_name`           | `curl_mime_name`                         | ✓     |
| `curl_mime_subparts`       | `curl_mime_subparts`                     | ✓     |
| `curl_mime_type`           | `curl_mime_type`                         | ✓     |
| `curl_multi_add_handle`    | `curl_multi_add_handle`                  | ✓     |
| `curl_multi_assign`        |                                          |       |
| `curl_multi_cleanup`       | `curl_multi_cleanup`                     | ✓     |
| `curl_multi_fdset`         |                                          |       |
| `curl_multi_info_read`     | `curl_multi_info_read`                   | ✓     |
| `curl_multi_init`          | `curl_multi_init`                        | ✓     |
| `curl_multi_perform`       | `curl_multi_perform`                     | ✓     |
| `curl_multi_poll`          | `curl_multi_pause`                       | ✓     |
| `curl_multi_remove_handle` | `curl_multi_remove_handle`               | ✓     |
| `curl_multi_socket_action` |                                          |       |
| `curl_multi_setopt`        |                                          |       |
| `curl_multi_strerror`      | `curl_multi_strerror`                    | ✓     |
| `curl_multi_timeout`       | `curl_multi_timeout`                     | ✓     |
| `curl_multi_wakeup`        | `curl_multi_wakeup`                      | ✓     |
| `curl_multi_wait`          |                                          |       |
| `curl_pushheader_byname`   |                                          |       |
| `curl_pushheader_bynum`    |                                          |       |
| `curl_share_cleanup`       |                                          |       |
| `curl_share_init`          |                                          |       |
| `curl_share_setopt`        |                                          |       |
| `curl_share_strerror`      |                                          |       |
| `curl_slist_append`        | `curl_slist_append`                      | ✓     |
| `curl_slist_free_all`      | `curl_slist_free_all`                    | ✓     |
| `curl_strequal`            |                                          |       |
| `curl_strnequal`           |                                          |       |
| `curl_unescape`            | `curl_unescape`                          | ✓     |
| `curl_version`             | `curl_version`                           | ✓     |
| `curl_version_info`        | `curl_version_info`                      | ✓     |

| C Constant Name     | Fortran Interface Name | Bound |
|---------------------|------------------------|-------|
| `CURLVERSION_NOW`   | `curl_version_now`     | ✓     |

## Fortran Package Manager

This projects supports the
[Fortran Package Manager](https://github.com/fortran-lang/fpm) (*fpm*). To build
the project with *fpm*, run:

```
$ fpm build --profile=release
```

The example applications are available with the ``fpm run --example`` command.

You can add *fortran-curl* to your `fpm.toml` with:

```toml
[dependencies]
fortran-curl = { git = "https://github.com/interkosmos/fortran-curl.git" }
```

## Contribute

For smaller changes:

1. Fork this repository from GitHub.
2. Create a branch off **master**.
3. Commit your changes.
4. Send a pull request.

For larger changes:

1. Join the [Discourse Group](https://fortran-lang.discourse.group/).
2. Discuss your proposal on the Group.
3. When consensus is reached, implement it as described above.

## Licence

ISC
