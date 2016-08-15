FROM troyfontaine/armhf-alpinelinux:3.3
COPY scripts/mkimage-alpine.bash scripts/apk-install scripts/qemu-arm-static /
RUN /apk-install bash tzdata
ENTRYPOINT ["/mkimage-alpine.bash"]
