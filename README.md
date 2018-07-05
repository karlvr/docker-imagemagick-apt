# Docker container to build ImageMagick APT packages

Builds a Docker container suitable for building ImageMagick, including installing all of the required dependencies.

You need to provide a `gpg.txt` file containing a GPG private key suitable for importing into gpg inside the container.

You can customise the `build.sh` file to download and build a different version of ImageMagick.

## Build the Docker container

```
docker build -t imagemagick-build .
```

## Run the Docker container to create the APT packages

You need to create a `gpg.txt` file containing your GPG private key that is used to sign
the build products. It is linked into the container as part of the run command.

Your PPA ID looks like `ppa:0k53d-karl-f830m/imagemagick`.

You will be prompted to enter your GPG private key password twice near the end of the build.

```
docker run -it \
    -v $(pwd)/gpg.txt:/root/gpg.txt \
    -v $(pwd)/build.sh:/root/build.sh \
    -e NAME="Your full name" \
    -e EMAIL="Your email address matching your GPG key" \
    -e PPA_ID="Your PPA ID" \
    imagemagick-build
```
