# ANTsRCore-arm64

This is a minimal repository to debug the ANTs and ANTsRCore installation in a Docker container for arm64 (Mac OS M1 Chip) architecture.

## Build full image

First, clone this repository:

```sh
git clone https://github.com/vgonzenbach/ANTsRCore-arm64.git
cd ANTsRCore-arm64
```

Then, to build the image and save a log, run the following command (note that the build fails on arm64 so an image won't be produced but the log is the main purpose):

```sh
# for clean build logs may need to clear the cache (!!) with: docker builder prune -a
docker build -t antsrcore-arm64-debug . &> full_build.log
```

This attempts to install ANTs, R, ITKR, and ANTsRCore (in that order) inside the docker image.

##  Build intermediary images

To build an intermediary image with only ANTs, run:

```sh
# only installs ANTs
head -n15 Dockerfile | docker build -t ants-arm64-debug -
```

Then you can test the ANTs installation: 
```sh
# this should output `/opt/ants-2.4.3/antsRegistration` when the installation is successful
docker run --rm ants-arm64-debug which antsRegistration
```

Note that an image is produced but the ANTs installation is not successful.

[TODO: enter url for built docker image]

To build up to ITKR (this is successful):

```sh
head -n81 Dockerfile | docker build -t itkr-arm64-debug -
```

And to test the ITKR installation, run:

```sh
# this should output `/usr/local/lib/R/library/ITKR` when the installation is successful
docker run --rm itkr-arm64-debug Rscript -e "system.file(package='ITKR')"
```

[TODO: enter url for built docker image]

## Notes

The portion of the `Dockerfile` that installs ANTs was generated with `neurodocker version 0.9.4` using the following command:

```sh
neurodocker generate docker --base-image debian:buster \
# --pkg-manager apt \
# --ants version=2.4.1 \ > Dockerfile
# after that lines were commented out and ants version was replaced by 2.4.3 throughout the resulting Dockerfile
```