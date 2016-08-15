FROM scratch

MAINTAINER Troy Fontaine

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
ARG ALPINE_VERSION
ARG VERSION
LABEL org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.docker.dockerfile="/versions/stock-3.3/Dockerfile" \
    org.label-schema.license="BSD" \
    org.label-schema.name="armhf-alpinelinux" \
    org.label-schema.url="https://github.com/troyfontaine/armhf-alpinelinux" \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-type="Git" \
    org.label-schema.vcs-url="https://github.com/troyfontaine/armhf-alpinelinux" \
    org.label-schema.docker.cmd="docker run --rm troyfontaine/armhf-alpinelinux:3.3 [args]" \
    org.label-schema.version=$VERSION \
    org.label-schema.schema-version="1.0" \
    com.troyfontaine.architecture="ARMv7l" \
    com.troyfontaine.alpine-version=$ALPINE_VERSION

ADD rootfs.tar.gz /