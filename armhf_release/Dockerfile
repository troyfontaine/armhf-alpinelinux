# Build base image
FROM scratch as builder

ARG ALPINE_DOWNLOAD

ADD $ALPINE_DOWNLOAD /

# Customize the image with QEMU support
FROM builder as cibuilder

ARG ALPINE_VERSION
ARG ALPINE_PACKAGES
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION

LABEL org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.docker.dockerfile="/Dockerfile" \
    org.label-schema.license="BSD" \
    org.label-schema.name="armhf-alpinelinux" \
    org.label-schema.url="https://armhf-alpinelinux.troyfontaine.com" \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-type="Git" \
    org.label-schema.vcs-url="https://github.com/troyfontaine/armhf-alpinelinux" \
    org.label-schema.docker.cmd="docker run --rm troyfontaine/armhf-alpinelinux:$ALPINE_VERSION [args]" \
    org.label-schema.version=$VERSION \
    org.label-schema.schema-version="1.0" \
    com.troyfontaine.architecture="ARMv7l" \
    com.troyfontaine.alpine-version=$ALPINE_VERSION \
    maintainer="Troy Fontaine"

ENV QEMU_EXECVE 1

# Modified version of qemu https://github.com/resin-io/qemu
# Highly inspired from https://github.com/resin-io-projects/armv7hf-debian-qemu
COPY qemu/  /usr/bin/
COPY prep.sh /

RUN [ "/usr/bin/qemu-arm-static", "/bin/sh", "-c", "mv /bin/sh /bin/sh.real; ln -s /bin/sh.real /bin/sh" ]

RUN [ "cross-build-start" ]

RUN /prep.sh $ALPINE_PACKAGES && rm /prep.sh

RUN [ "cross-build-end" ]

# Remove QEMU support to allow for use in multi-architecture images
RUN [ "/usr/bin/qemu-arm-static", "/bin/sh", "-c", "mv /bin/sh.real /bin/sh; rm /usr/bin/cross-build-start; rm /usr/bin/cross-build-end; rm /usr/bin/resin-xbuild; rm /usr/bin/qemu-arm-static" ]

FROM cibuilder

COPY --from=builder / .

CMD [ "/bin/bash" ]
