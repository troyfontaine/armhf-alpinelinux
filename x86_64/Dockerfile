# Build base image
FROM scratch as builder

ARG ALPINE_DOWNLOAD

ADD $ALPINE_DOWNLOAD /

FROM builder

ARG ALPINE_VERSION
ARG ALPINE_PACKAGES
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION

LABEL org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.docker.dockerfile="/Dockerfile" \
    org.label-schema.license="BSD" \
    org.label-schema.name="x86_64-alpinelinux" \
    org.label-schema.url="https://armhf-alpinelinux.troyfontaine.com" \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-type="Git" \
    org.label-schema.vcs-url="https://github.com/troyfontaine/x86_64-alpinelinux" \
    org.label-schema.docker.cmd="docker run --rm troyfontaine/x86_64-alpinelinux:$ALPINE_VERSION [args]" \
    org.label-schema.version=$VERSION \
    org.label-schema.schema-version="1.0" \
    com.troyfontaine.architecture="x86_64" \
    com.troyfontaine.alpine-version=$ALPINE_VERSION \
    maintainer="Troy Fontaine"

COPY prep.sh /

RUN /prep.sh $ALPINE_PACKAGES && rm /prep.sh

CMD [ "/bin/sh" ]
