FROM troyfontaine/container-maker
COPY scripts/mkimage-alpine.bash scripts/apk-install /
COPY qemu/qemu-arm-static /usr/bin/
RUN /apk-install bash tzdata
ENTRYPOINT ["/mkimage-alpine.bash"]
