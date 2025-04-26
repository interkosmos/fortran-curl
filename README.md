# fortran-curl

A collection of ISO C binding interfaces to
[libcurl](https://curl.haxx.se/libcurl/) ≥ 8.10.0 for Fortran 2008. The library
has been tested with GCC 14 and LLVM 20. See [COVERAGE](COVERAGE.md) for an
overview of bound procedures.

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

Clone the repository, then run `make` to build and install the interfaces to
`/opt`:

```
$ git clone --depth 1 https://github.com/interkosmos/fortran-curl
$ cd fortran-curl/
$ make
$ make install PREFIX=/opt
```

You can override the default compilers by passing the `CC` and `FC` arguments,
for example:

```
$ make CC=icx FC=ifx
```

On Linux, you may have to change the prefix to `/usr`:

```
$ make PREFIX=/usr
```

Link your Fortran application against `/opt/lib/libfortran-curl.a -lcurl`.

## Examples

Examples are provided in directory `examples/`:

* **dict** queries a [DICT](https://en.wikipedia.org/wiki/DICT) server on TCP port 2628.
* **download** fetches a remote file.
* **getinfo** prints request-related information and response headers to console.
* **gopher** prints the contents of a remote Gopher map file.
* **http** makes an HTTP GET request.
* **imap** examines the `INBOX` of an IMAP mailbox (SSL).
* **mqtt** posts a message to an MQTT topic.
* **multi** makes multiple HTTP requests at once.
* **post** makes an HTTP POST request.
* **smtp** sends an e-mail via SMTP (SSL).
* **url** demonstrates the URL API.
* **version** outputs cURL version information.

Build an example with:

```
$ make <name>
```

Build all by running `make examples`.

## Fortran Package Manager

This project supports the
[Fortran Package Manager](https://github.com/fortran-lang/fpm) (FPM). To build
the project with FPM, run:

```
$ fpm build --profile release
```

The example programs are available with the ``fpm run --example`` command.

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
