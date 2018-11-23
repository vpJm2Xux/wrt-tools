FROM node:8
RUN \
	apt-get update && \
	apt-get install -y zip openssl libluajit-5.1-dev && \
	\
	curl -sSLo /usr/bin/mcli https://dl.minio.io/client/mc/release/linux-amd64/mc && \
	chmod +x /usr/bin/mcli && \
	\
	echo OK!
