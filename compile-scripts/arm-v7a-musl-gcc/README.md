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

# Compiling for MacOS

Place build.sh in /opt/cross/arm-v7a and make sure filesystem is case
sensitive. Add to path GNU awk, install, readlink, one way is add symlinks
to brew gawk etc to some folder and add the folder in front of the PATH.
Add MacOS pathes and compile.
