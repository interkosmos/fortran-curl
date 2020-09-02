# fortran-curl
A collection of ISO C binding interfaces to
[libcurl](https://curl.haxx.se/libcurl/) for Fortran 2008. At the moment, this
project is just a proof of concept. Compilation has been tested with GNU
Fortran 10 and cURL 7.72.0.

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
$ make FC=gfortran10
```

On Linux, you may want to change the prefix to `/usr`:

```
$ make PREFIX=/usr
```

Link the compiled static library `libfortran-curl.a` with your Fortran
application.

## Examples
Examples are provided in directory `examples/`:

* **gopher** prints the contents of a remote Gopher map file.
* **http** makes an HTTP GET request.
* **imap** examines the `INBOX` of an IMAP mailbox (SSL).
* **smtp** sends an e-mail via SMTP (SSL).
* **version** outputs cURL version information.

Build an example with:

```
$ make <name>
```

## Coverage
| C Function Name       | Fortran Interface Name                  | Bound |
|-----------------------|-----------------------------------------|-------|
| `curl_easy_init`      | `curl_easy_init`                        | ✓     |
| `curl_easy_perform`   | `curl_easy_perform`                     | ✓     |
| `curl_easy_cleanup`   | `curl_easy_cleanup`                     | ✓     |
| `curl_easy_setopt`    | `curl_easy_setopt`, `curl_easy_setopt_` | ✓     |
| `curl_slist_append`   | `curl_slist_append`                     | ✓     |
| `curl_slist_free_all` | `curl_slist_free_all`                   | ✓     |
| `curl_version_info`   | `curl_version_info`                     | ✓     |

| C Constant Name     | Fortran Interface Name | Bound |
|---------------------|------------------------|-------|
| `CURLVERSION_NOW`   | `curl_version_now`     | ✓     |

## Licence
ISC
