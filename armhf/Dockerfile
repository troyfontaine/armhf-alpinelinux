FROM scratch

ENV QEMU_EXECVE 1

ARG ALPINE_DOWNLOAD
ARG ALPINE_VERSION
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

ADD $ALPINE_DOWNLOAD /

# Modified version of qemu https://github.com/resin-io/qemu
# Highly inspired from https://github.com/resin-io-projects/armv7hf-debian-qemu
COPY qemu/  /usr/bin/

RUN [ "/usr/bin/qemu-arm-static", "/bin/sh", "-c", "mv /bin/sh /bin/sh.real; ln -s /bin/sh.real /bin/sh" ]

COPY localtime /etc/localtime

COPY shadow /etc/shadow

ONBUILD RUN apk upgrade --available

ENTRYPOINT [ "/usr/bin/qemu-arm-static", "/usr/bin/env", "QEMU_EXECVE=1" ]

CMD [ "/bin/sh" ]
