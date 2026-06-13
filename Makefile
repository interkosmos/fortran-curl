.POSIX:
.SUFFIXES:

FC      = gfortran
CC      = gcc
AR      = ar
RM      = /bin/rm
PREFIX  = /usr/local

DEBUG   = -g -O0 -Wall -fmax-errors=1
RELEASE = -O2
FLAGS   = $(RELEASE)

FFLAGS  = -I$(PREFIX)/include $(FLAGS)
CFLAGS  = -I$(PREFIX)/include $(FLAGS)
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
	$(RM) -rf *.mod
	$(RM) -rf *.o
	$(RM) -rf $(TARGET)
	$(RM) -rf $(DICT)
	$(RM) -rf $(DOWNLOAD)
	$(RM) -rf $(GETINFO)
	$(RM) -rf $(GOPHER)
	$(RM) -rf $(HTTP)
	$(RM) -rf $(IMAP)
	$(RM) -rf $(MQTT)
	$(RM) -rf $(MULTI)
	$(RM) -rf $(POST)
	$(RM) -rf $(SMTP)
	$(RM) -rf $(URL)
	$(RM) -rf $(VERSION)
