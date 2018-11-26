FROM debian

RUN \
	dpkg --add-architecture i386 && \
	apt-get update && \
	apt-get install -y autoconf  automake bc bison bzip2 ccache cmake flex \
		gcc gettext git libc6:i386 libstdc++6:i386 libtool make \
		net-tools pkg-config subversion tar wget \
		xz-utils patch libssl-dev zip p7zip gnupg libz-dev && \
	wget https://github.com/vpJm2Xux/wrt-tools/releases/download/0.0.11/arm-v7a-musl.tar.xz && \
	tar xvf arm-v7a-musl.tar.xz && \
	rm arm-v7a-musl.tar.xz && \
	\
	apt-get install -y curl g++ python3 \
		software-properties-common qemu-user-static && \
	\
	cd /usr/src && \
	git clone https://github.com/ruslo/polly.git && \
	\
	curl -sSL https://github.com/Kitware/CMake/releases/download/v3.13.0/cmake-3.13.0-Linux-x86_64.sh \
		-o /tmp/cmake.sh && \
	\
	sh /tmp/cmake.sh --prefix=/opt/cross/arm-v7a/staging_dir/host --skip-license && \
	rm /tmp/cmake.sh && \
	\
	curl -sSLo /usr/bin/mcli https://dl.minio.io/client/mc/release/linux-amd64/mc && \
	chmod +x /usr/bin/mcli && \
	\
	echo OK!

RUN \
	cd /usr/src && \
	git clone https://github.com/cgreen-devs/cgreen.git && \
	cd cgreen && \
	cmake -DCMAKE_INSTALL_PREFIX:PATH=/usr . && \
	make install && \
	cd .. && rm -rf cgreen && \
	\
	echo OK!

ENV PATH /opt/cross/arm-v7a/staging_dir/host/bin:$PATH
ENV PATH /opt/cross/arm-v7a/staging_dir/toolchain-arm_cortex-a9_gcc-6.3.0_musl-1.1.16_eabi/bin:$PATH
ENV STAGING_DIR /opt/cross/arm-v7a/staging_dir/toolchain-arm_cortex-a9_gcc-6.3.0_musl-1.1.16_eabi

ENV ROUTER_DDWRT_TOOLCHAIN arm-openwrt-linux-muslgnueabi
ENV ROUTER_DDWRT_TOOLCHAIN_ROOT $STAGING_DIR
ENV PATH /usr/src/polly/bin:$PATH
