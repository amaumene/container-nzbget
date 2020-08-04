FROM alpine:edge

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="my nzbget container. ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="amaumene"

RUN \
 echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
 echo "**** install packages ****" && \
 apk add --no-cache \
	p7zip \
	python2 \
	unrar \
	unzip \
	curl \
	nzbget && \
 echo "**** configure nzbget ****" && \
 cp /usr/share/nzbget/nzbget.conf /defaults/nzbget.conf && \
 echo "**** cleanup ****" && \
 rm -rf \
	/tmp/*

# add local files
COPY root/ /

# ports and volumes
VOLUME /config /downloads
EXPOSE 6789
