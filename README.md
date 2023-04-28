# fortran-curl
A collection of ISO C binding interfaces to
[libcurl](https://curl.haxx.se/libcurl/) for Fortran 2008. Compilation has been
tested with GNU Fortran 12 and cURL 8.0.1. The library is also available on
[MacPorts](https://ports.macports.org/port/fortran-curl/).

## Dependencies
Install cURL with development headers. On FreeBSD, run:

```
# pkg install ftp/curl
```

## Compilation
Clone the repository and then run `make` to build the interfaces:

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
* **post** makes an HTTP POST request.
* **smtp** sends an e-mail via SMTP (SSL).
* **version** outputs cURL version information.

Build an example with:

```
$ make <name>
```

## Coverage
| C Function Name       | Fortran Interface Name                                                | Bound |
|-----------------------|-----------------------------------------------------------------------|-------|
| `curl_easy_cleanup`   | `curl_easy_cleanup`                                                   | ✓     |
| `curl_easy_escape`    | `curl_easy_escape`                                                    | ✓     |
| `curl_easy_getinfo`   | `curl_easy_getinfo`, `curl_easy_getinfo_`                             | ✓     |
| `curl_easy_init`      | `curl_easy_init`                                                      | ✓     |
| `curl_easy_perform`   | `curl_easy_perform`                                                   | ✓     |
| `curl_easy_setopt`    | `curl_easy_setopt`, `curl_easy_setopt_funptr`, `curl_easy_setopt_ptr` | ✓     |
| `curl_easy_strerror`  | `curl_easy_strerror`                                                  | ✓     |
| `curl_escape`         | `curl_escape`                                                         | ✓     |
| `curl_slist_append`   | `curl_slist_append`                                                   | ✓     |
| `curl_slist_free_all` | `curl_slist_free_all`                                                 | ✓     |
| `curl_version_info`   | `curl_version_info`                                                   | ✓     |

| C Constant Name     | Fortran Interface Name | Bound |
|---------------------|------------------------|-------|
| `CURLVERSION_NOW`   | `curl_version_now`     | ✓     |

## Support for fpm
This projects supports the Fortran Package Manager
([fpm](https://github.com/fortran-lang/fpm)). To build the project with *fpm*,
run:

```
$ fpm build --profile=release
```

The example applications are available with the ``fpm run --example`` command.

You can use ``fortran-curl`` in your *fpm* projects with:

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
