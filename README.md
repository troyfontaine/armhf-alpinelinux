# armhf-alpinelinux

[![Docker Stars](https://img.shields.io/docker/stars/troyfontaine/armhf-alpinelinux.svg)]()
[![Docker Pulls](https://img.shields.io/docker/pulls/troyfontaine/armhf-alpinelinux.svg)]()
[![](https://images.microbadger.com/badges/version/troyfontaine/armhf-alpinelinux.svg)](http://microbadger.com/images/troyfontaine/armhf-alpinelinux "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/troyfontaine/armhf-alpinelinux.svg)](http://microbadger.com/images/troyfontaine/armhf-alpinelinux "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/commit/troyfontaine/armhf-alpinelinux.svg)](http://microbadger.com/images/troyfontaine/armhf-alpinelinux "Get your own commit badge on microbadger.com")


A super small Docker image based on [Alpine Linux][alpine]. Forked from [Glider Labs Alpine Image][gliderlabs].  The image is less than 5 MB and has access to a package repository that is much more complete than other BusyBox based images.  Included in this version is a qemu binary that allows the container when created on an ARM device to run on an x86/x86_64 system (with the exception of Boot2Docker it seems in testing).

## How to build for ARMHF?

You can use this repo directly on a Raspberry Pi to create an ARMHF-compatible Alpine Image that can run on other platforms.  The "special sauce" is the qemu-arm-static binary copied to /usr/bin/ in the Dockerfile for each version.

## Why?

Docker images today are big. Usually much larger than they need to be. There are a lot of ways to make them smaller, but the Docker populace still jumps to the `ubuntu` base image for most projects. The size savings over `ubuntu` and other bases are huge:

```
REPOSITORY          				TAG           IMAGE ID          VIRTUAL SIZE
troyfontaine/armhf-alpinelinux   	latest        72b80f01d847      6.83 MB
debian              				latest        4d6ce913b130      84.98 MB
ubuntu              				latest        b39b81afc8ca      188.3 MB
centos              				latest        8efe422e6104      210 MB
```

There are images such as `progrium/busybox` which get us very close to a minimal container and package system. But these particular BusyBox builds piggyback on the OpenWRT package index which is often lacking and not tailored towards generic everyday applications. Alpine Linux has a much more complete and up to date [package index][alpine-packages]:

```console
$ docker run progrium/busybox opkg-install nodejs
Unknown package 'nodejs'.
Collected errors:
* opkg_install_cmd: Cannot install package nodejs.

$ docker run gliderlabs/alpine apk add --no-cache nodejs
fetch http://alpine.gliderlabs.com/alpine/v3.3/main/x86_64/APKINDEX.tar.gz
fetch http://alpine.gliderlabs.com/alpine/v3.3/community/x86_64/APKINDEX.tar.gz
(1/4) Installing libgcc (5.3.0-r0)
(2/4) Installing libstdc++ (5.3.0-r0)
(3/4) Installing libuv (1.7.5-r0)
(4/4) Installing nodejs (4.2.3-r0)
Executing busybox-1.24.1-r7.trigger
OK: 29 MiB in 15 packages
```

This makes Alpine Linux a great image base for utilities and even production applications. [Read more about Alpine Linux here][alpine-about] and you can see how their mantra fits in right at home with Docker images.

## Usage

Stop doing this:

```dockerfile
FROM ubuntu-debootstrap:14.04
RUN apt-get update -q \
  && DEBIAN_FRONTEND=noninteractive apt-get install -qy mysql-client \
  && apt-get clean \
  && rm -rf /var/lib/apt
ENTRYPOINT ["mysql"]
```
This took 19 seconds to build and yields a 164 MB image. Eww. Start doing this:

```dockerfile
FROM troyfontaine/armhf-alpinelinux:3.3
RUN apk add --no-cache mysql-client
ENTRYPOINT ["mysql"]
```

Only 3 seconds to build and results in a 36 MB image! Hooray!

## Inspiration

The motivation for this project and modifications to `mkimage.sh` are highly inspired by Eivind Uggedal (uggedal) and Luis Lavena (luislavena). They have made great strides in getting Alpine Linux running as a Docker container. Check out their [mini-container/base][mini-base] image as well.

## License

The code in this repository, unless otherwise noted, is BSD licensed. See the `LICENSE` file in this repository.

[alpine]: http://alpinelinux.org/
[gliderlabs]: http://github.com/gliderlabs/docker-alpine
