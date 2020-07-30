FROM lsiobase/alpine:edge

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
	nzbget &&
 echo "**** configure nzbget ****" && \
 cp /app/nzbget/nzbget.conf /defaults/nzbget.conf && \
 sed -i \
	-e "s#\(MainDir=\).*#\1/downloads#g" \
	-e "s#\(ScriptDir=\).*#\1$\{MainDir\}/scripts#g" \
	-e "s#\(WebDir=\).*#\1$\{AppDir\}/webui#g" \
	-e "s#\(ConfigTemplate=\).*#\1$\{AppDir\}/webui/nzbget.conf.template#g" \
 /defaults/nzbget.conf && \
 echo "**** cleanup ****" && \
 rm -rf \
	/tmp/*

# add local files
COPY root/ /

# ports and volumes
VOLUME /config /downloads
EXPOSE 6789
