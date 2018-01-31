# Compiling GCC from LEDE in docker

This folder contains build script to compile LEDE toolchain from
LEDE and compile it in /opt/cross/arm-v7a folder.

Dockerfile can be used to compile it using debian image from docker.

```
docker build --tag arm-v7a-build .
```

Once container is built it has an archive with binary toolchain on it.
To save the output run the container

```
docker run arm-v7a-build > arm-v7a-musl.tar.xz
```
