.POSIX:
.SUFFIXES:

FC      = gfortran
CC      = gcc
PREFIX  = /usr/local
DEBUG   = #-ggdb3 -O0

FFLAGS  = $(DEBUG) -Wall -Wno-unused-dummy-argument -std=f2008 -fmax-errors=1 -fcheck=all
CFLAGS  = $(DEBUG) -Wall
LDFLAGS = -I$(PREFIX)/include/ -L$(PREFIX)/lib/
LDLIBS  = -lcurl

GOPHER  = gopher
HTTP    = http
IMAP    = imap
SMTP    = smtp
VERSION = version

.PHONY: all clean gopher http imap smtp version

all:
	$(CC) $(CFLAGS) -c src/curlv.c
	$(FC) $(FFLAGS) -c src/curl.f90

gopher: all
	$(FC) $(FFLAGS) $(LDFLAGS) -o $(GOPHER) examples/gopher/gopher.f90 curl.o curlv.o $(LDLIBS)

http: all
	$(FC) $(FFLAGS) $(LDFLAGS) -o $(HTTP) examples/http/http.f90 curl.o curlv.o $(LDLIBS)

imap: all
	$(FC) $(FFLAGS) $(LDFLAGS) -o $(IMAP) examples/imap/imap.f90 curl.o curlv.o $(LDLIBS)

smtp: all
	$(FC) $(FFLAGS) $(LDFLAGS) -o $(SMTP) examples/smtp/smtp.f90 curl.o curlv.o $(LDLIBS)

version: all
	$(FC) $(FFLAGS) $(LDFLAGS) -o $(VERSION) examples/version/version.f90 curl.o curlv.o $(LDLIBS)

clean:
	if [ `ls -1 *.mod 2>/dev/null | wc -l` -gt 0 ]; then rm *.mod; fi
	if [ `ls -1 *.o 2>/dev/null | wc -l` -gt 0 ]; then rm *.o; fi
	if [ -e $(GOPHER) ]; then rm $(GOPHER); fi
	if [ -e $(HTTP) ]; then rm $(HTTP); fi
	if [ -e $(IMAP) ]; then rm $(IMAP); fi
	if [ -e $(SMTP) ]; then rm $(SMTP); fi
	if [ -e $(VERSION) ]; then rm $(VERSION); fi
