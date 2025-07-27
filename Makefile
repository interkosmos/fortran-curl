.POSIX:
.SUFFIXES:

FC      = gfortran
CC      = gcc
AR      = ar
PREFIX  = /usr/local

DEBUG   = -g -O0 -Wall -fmax-errors=1
RELEASE = -O2

FFLAGS  = -I$(PREFIX)/include $(RELEASE)
CFLAGS  = -I$(PREFIX)/include $(RELEASE)
LDFLAGS = -L$(PREFIX)/lib
LDLIBS  = -lcurl
ARFLAGS = rcs
INCDIR  = $(PREFIX)/include/libfortran-curl
LIBDIR  = $(PREFIX)/lib
TARGET  = libfortran-curl.a

DICT     = dict
DOWNLOAD = download
GETINFO  = getinfo
GOPHER   = gopher
HTTP     = http
IMAP     = imap
MQTT     = mqtt
MULTI    = multi
POST     = post
SMTP     = smtp
URL      = url
VERSION  = version

SRC = src/curl.f90 src/curl_easy.f90 src/curl_multi.f90 src/curl_urlapi.f90 \
      src/curl_util.F90 src/curl_macro.c
MOD = curl.mod curl_easy.mod curl_multi.mod curl_urlapi.mod curl_util.mod
OBJ = curl.o curl_easy.o curl_multi.o curl_urlapi.o curl_util.o curl_macro.o

.PHONY: all clean examples

all: $(TARGET)

examples: $(DICT) $(DOWNLOAD) $(GETINFO) $(GOPHER) $(HTTP) $(IMAP) $(MQTT) \
          $(MULTI) $(POST) $(SMTP) $(URL) $(VERSION)

$(TARGET): $(SRC)
	$(CC) $(CFLAGS) -c src/curl_macro.c
	$(FC) $(FFLAGS) -c src/curl_util.F90
	$(FC) $(FFLAGS) -c src/curl_easy.f90
	$(FC) $(FFLAGS) -c src/curl_multi.f90
	$(FC) $(FFLAGS) -c src/curl_urlapi.f90
	$(FC) $(FFLAGS) -c src/curl.f90
	$(AR) $(ARFLAGS) $(TARGET) $(OBJ)

$(DICT): examples/dict/dict.f90 $(TARGET)
	$(FC) $(FFLAGS) $(LDFLAGS) -o $(DICT) examples/dict/dict.f90 $(TARGET) $(LDLIBS)

$(DOWNLOAD): examples/download/download.f90 $(TARGET)
	$(FC) $(FFLAGS) $(LDFLAGS) -o $(DOWNLOAD) examples/download/download.f90 $(TARGET) $(LDLIBS)

$(GETINFO): examples/getinfo/getinfo.f90 $(TARGET)
	$(FC) $(FFLAGS) $(LDFLAGS) -o $(GETINFO) examples/getinfo/getinfo.f90 $(TARGET) $(LDLIBS)

$(GOPHER): examples/gopher/gopher.f90 $(TARGET)
	$(FC) $(FFLAGS) $(LDFLAGS) -o $(GOPHER) examples/gopher/gopher.f90 $(TARGET) $(LDLIBS)

$(HTTP): examples/http/http.f90 $(TARGET)
	$(FC) $(FFLAGS) $(LDFLAGS) -o $(HTTP) examples/http/http.f90 $(TARGET) $(LDLIBS)

$(IMAP): examples/imap/imap.f90 $(TARGET)
	$(FC) $(FFLAGS) $(LDFLAGS) -o $(IMAP) examples/imap/imap.f90 $(TARGET) $(LDLIBS)

$(MQTT): examples/mqtt/mqtt.f90 $(TARGET)
	$(FC) $(FFLAGS) $(LDFLAGS) -o $(MQTT) examples/mqtt/mqtt.f90 $(TARGET) $(LDLIBS)

$(MULTI): examples/multi/multi.f90 $(TARGET)
	$(FC) $(FFLAGS) $(LDFLAGS) -o $(MULTI) examples/multi/multi.f90 $(TARGET) $(LDLIBS)

$(POST): examples/post/post.f90 $(TARGET)
	$(FC) $(FFLAGS) $(LDFLAGS) -o $(POST) examples/post/post.f90 $(TARGET) $(LDLIBS)

$(SMTP): examples/smtp/smtp.f90 $(TARGET)
	$(FC) $(FFLAGS) $(LDFLAGS) -o $(SMTP) examples/smtp/smtp.f90 $(TARGET) $(LDLIBS)

$(URL): examples/url/url.f90 $(TARGET)
	$(FC) $(FFLAGS) $(LDFLAGS) -o $(URL) examples/url/url.f90 $(TARGET) $(LDLIBS)

$(VERSION): examples/version/version.f90 $(TARGET)
	$(FC) $(FFLAGS) $(LDFLAGS) -o $(VERSION) examples/version/version.f90 $(TARGET) $(LDLIBS)

install: $(TARGET)
	@echo "--- Installing $(TARGET) to $(LIBDIR)/ ..."
	install -d $(LIBDIR)
	install -m 644 $(TARGET) $(LIBDIR)/
	@echo "--- Installing module files to $(INCDIR)/ ..."
	install -d $(INCDIR)
	install -m 644 $(MOD) $(INCDIR)/

clean:
	if [ `ls -1 *.mod 2>/dev/null | wc -l` -gt 0 ]; then rm *.mod; fi
	if [ `ls -1 *.o 2>/dev/null | wc -l` -gt 0 ]; then rm *.o; fi
	if [ -e $(TARGET) ]; then rm $(TARGET); fi
	if [ -e $(DICT) ]; then rm $(DICT); fi
	if [ -e $(DOWNLOAD) ]; then rm $(DOWNLOAD); fi
	if [ -e $(GETINFO) ]; then rm $(GETINFO); fi
	if [ -e $(GOPHER) ]; then rm $(GOPHER); fi
	if [ -e $(HTTP) ]; then rm $(HTTP); fi
	if [ -e $(IMAP) ]; then rm $(IMAP); fi
	if [ -e $(MQTT) ]; then rm $(MQTT); fi
	if [ -e $(MULTI) ]; then rm $(MULTI); fi
	if [ -e $(POST) ]; then rm $(POST); fi
	if [ -e $(SMTP) ]; then rm $(SMTP); fi
	if [ -e $(URL) ]; then rm $(URL); fi
	if [ -e $(VERSION) ]; then rm $(VERSION); fi
