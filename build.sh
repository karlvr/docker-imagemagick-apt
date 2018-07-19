#!/bin/bash -xeu

if [ ! -f gpg.txt ]; then
	echo "Missing gpg.txt" >&2
	exit 1
fi

if [ -z "${NAME:-}" ]; then
	echo "Missing environment variable: NAME" >&2
	exit 1
fi
if [ -z "${EMAIL:-}" ]; then
	echo "Missing environment variable: EMAIL" >&2
	exit 1
fi
if [ -z "${PPA_ID:-}" ]; then
	echo "Missing environment variable: PPA_ID" >&2
	exit 1
fi

# Import GPG key
gpg --import gpg.txt

# Download source
# Found URLs for latest Xenial package from: https://launchpad.net/ubuntu/+source/imagemagick
curl -OL https://launchpad.net/ubuntu/+archive/primary/+sourcefiles/imagemagick/8:6.8.9.9-7ubuntu5.12/imagemagick_6.8.9.9.orig.tar.xz
curl -OL https://launchpad.net/ubuntu/+archive/primary/+sourcefiles/imagemagick/8:6.8.9.9-7ubuntu5.12/imagemagick_6.8.9.9-7ubuntu5.12.debian.tar.xz

# Build
mkdir build
pushd build

tar Jxf ../*.debian.tar.xz

# Patch the Xenial control file to make the dpkg-dev dependency compatible with trusty
sed -e 's/dpkg-dev (>= 1.17.6)/dpkg-dev (>= 1.17.5)/' debian/control --in-place
sed -e 's/dpkg (>= 1.17.6)/dpkg (>= 1.17.5)/' debian/control --in-place

# Need to extract the orig archive to do a binary build
#tar xJf ../imagemagick_*.orig.tar.xz --strip-components 1

distribution=$(lsb_release -c -s)

dch -i --distribution ${distribution} Repackage for $distribution

debuild -S
popd

# Upload source package to Launchpad
dput $PPA_ID *.changes
