#!/bin/bash
cd $(dirname $0)
mkdir -p doc
mkdir -p ../../../man/man3 ../../../docs
#export GITHUB=FALSE
#export DEMO_OUTDIR=../../example
#export DEMO_SUBDIR=FALSE
export UFPP_DOCUMENT_DIR=$(pwd)
ufpp TESTPRG90 F90 --cstyle doxygen --verbose --allow_links -i dict.[fF][fF] -o ../dict.f90
txt2man doc/dict.1.man >../../../man/man3/dict.1
man2html ../../../man/man3/dict.1 > ../../../docs/dict.1.html
gzip -f ../../../man/man3/dict.1
(
cd ../../..
fpm-install
)
exit
