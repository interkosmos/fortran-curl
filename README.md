# fortran-curl
A collection of ISO C binding interfaces to
[libcurl](https://curl.haxx.se/libcurl/) for Fortran 2008. At the moment, this
project is just a proof of concept. Compilation has been tested with GNU
Fortran 9 and cURL 7.69.

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

You can override the default compiler by passing the `FC` argument, for
example:

```
$ make FC=gfortran9
```

On Linux, you may want to change to prefix to `/usr`:

```
$ make PREFIX=/usr
```

## Examples
Examples are provided in directory `examples/`:

* **http** makes an HTTP GET request.

Build an example with:

```
$ make <name>
```

## Coverage
| C Function Name     | Fortran Interface Name                                                                                                    | Bound |
|---------------------|---------------------------------------------------------------------------------------------------------------------------|-------|
| `curl_easy_init`    | `curl_easy_init`                                                                                                          | ✓     |
| `curl_easy_perform` | `curl_easy_perform`                                                                                                       | ✓     |
| `curl_easy_cleanup` | `curl_easy_cleanup`                                                                                                       | ✓     |
| `curl_easy_setopt`  | `curl_easy_setopt_char`, `curl_easy_setopt_fptr`, `curl_easy_setopt_int`, `curl_easy_setopt_long`, `curl_easy_setopt_ptr` | ✓     |
| `curl_version_info` | `curl_version_info`                                                                                                       | ✓     |

| C Constant Name     | Fortran Interface Name | Bound |
|---------------------|------------------------|-------|
| `CURLVERSION_NOW`   | `curl_version_now`     | ✓     |

## Licence
ISC
