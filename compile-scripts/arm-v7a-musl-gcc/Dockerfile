FROM debian
ADD build.sh /opt/cross/arm-v7a/build.sh
RUN \
	sh /opt/cross/arm-v7a/build.sh && \
	mv /opt/cross/arm-v7a/arm-v7a.tar.xz / && \
	rm -rf /opt/cross/arm-v7a
CMD cat /arm-v7a.tar.xz
