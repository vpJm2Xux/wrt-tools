FROM debian
ADD build.sh /opt/cross/build.sh
ADD patches /opt/cross/patches
RUN \
	sh /opt/cross/build.sh && \
	mv /opt/cross/arm-v7a/arm-v7a.tar.xz / && \
	rm -rf /opt/cross/arm-v7a
RUN \
	tar xf arm-v7a.tar.xz && \
	find /opt/cross/arm-v7a -type f -executable | \
		while read a; do strip $a; done || echo done && \
	tar cJf arm-v7a.tar.xz /opt/cross/arm-v7a
CMD cat /arm-v7a.tar.xz
