#!/bin/sh

docker build --tag dd-src .
docker run dd-src > dd-src.tar.xz
