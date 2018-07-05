FROM ubuntu:14.04

# Dependencies for building apts
RUN apt-get update && apt-get install -y --no-install-recommends \
	build-essential cdbs devscripts equivs fakeroot \
	debhelper dh-make gnupg dh-autoreconf dput \
	curl

# Build dependencies
RUN apt-get install -y --no-install-recommends debhelper pkg-config libltdl-dev dh-autoreconf \
	chrpath libfftw3-dev liblcms2-dev liblqr-1-0-dev \
	libfreetype6-dev libfontconfig1-dev \
	zlib1g-dev liblzma-dev libbz2-dev \
	libx11-dev libxext-dev libxt-dev \
	ghostscript libdjvulibre-dev libexif-dev \
	libjasper-dev libjpeg-dev \
	libopenexr-dev libperl-dev libpng-dev libtiff-dev \
	libwmf-dev \
	libpango1.0-dev librsvg2-bin librsvg2-dev libxml2-dev \
	pkg-kde-tools \
	dpkg-dev doxygen doxygen-latex graphviz libxml2-utils xsltproc

WORKDIR /root

ENTRYPOINT /root/build.sh

# Clean up
RUN apt-get clean && rm -rf /tmp/* /var/tmp/*

ENV EMAIL ""
ENV NAME ""
ENV PPA_ID ""
