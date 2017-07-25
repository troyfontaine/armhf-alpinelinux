setup() {
  docker history troyfontaine/armhf-alpinelinux:3.6 >/dev/null 2>&1
}

@test "ARM 3.6 version is correct" {
  run docker container run --rm troyfontaine/armhf-alpinelinux:3.6 cat /etc/os-release
  [ $status -eq 0 ]
  [ "${lines[2]}" = "VERSION_ID=3.6.2" ]
}

@test "ARM 3.6 package installs cleanly" {
  run docker container run --rm troyfontaine/armhf-alpinelinux:3.6 apk add --no-cache openssl
  [ $status -eq 0 ]
}

@test "ARM 3.6 timezone" {
  run docker container run --rm troyfontaine/armhf-alpinelinux:3.6 date +%Z
  [ $status -eq 0 ]
  [ "$output" = "UTC" ]
}

@test "ARM 3.6 repository list is correct" {
  run docker container run --rm troyfontaine/armhf-alpinelinux:3.6 cat /etc/apk/repositories
  [ $status -eq 0 ]
  [ "${lines[0]}" = "http://dl-cdn.alpinelinux.org/alpine/v3.6/main" ]
  [ "${lines[1]}" = "http://dl-cdn.alpinelinux.org/alpine/v3.6/community" ]
}

@test "ARM 3.6 cache is empty" {
  run docker container run --rm troyfontaine/armhf-alpinelinux:3.6 sh -c "ls -1 /var/cache/apk | wc -l"
  [ $status -eq 0 ]
  [ "$output" = "0" ]
}

@test "ARM 3.6 root password is disabled" {
  run docker container run --rm --user nobody troyfontaine/armhf-alpinelinux:3.6 su
  [ $status -eq 1 ]
}
