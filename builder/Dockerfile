FROM troyfontaine/armhf-alpinelinux:3.3

ENV QEMU_EXECVE 1

# Modified version of qemu https://github.com/resin-io/qemu
# Highly inspired from https://github.com/resin-io-projects/armv7hf-debian-qemu
COPY qemu/  /usr/bin/

#RUN [ "qemu-arm-static", "/bin/sh", "-c", "mv /bin/sh /bin/sh.real; ln -s /bin/sh.real /bin/sh" ]

# wrap the environment with qemu allowing building on x86_64 computer
RUN [ "cross-build-start" ]
COPY scripts/mkimage-alpine.bash scripts/apk-install /
RUN /apk-install bash tzdata

RUN [ "cross-build-end" ]

ENTRYPOINT [ "/usr/bin/qemu-arm-static", "/usr/bin/env", "QEMU_EXECVE=1" ]
CMD [ "/mkimage-alpine.bash" ]
