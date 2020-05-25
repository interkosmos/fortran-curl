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

HTTP    = http
SMTP    = smtp

.PHONY: all clean http smtp

all:
	$(CC) $(CFLAGS) -c src/curlv.c
	$(FC) $(FFLAGS) -c src/curl.f90

http: all
	$(FC) $(FFLAGS) $(LDFLAGS) -o $(HTTP) examples/http/http.f90 curl.o curlv.o $(LDLIBS)

smtp: all
	$(FC) $(FFLAGS) $(LDFLAGS) -o $(SMTP) examples/smtp/smtp.f90 curl.o curlv.o $(LDLIBS)

clean:
	rm *.mod *.o $(HTTP) $(SMTP)
