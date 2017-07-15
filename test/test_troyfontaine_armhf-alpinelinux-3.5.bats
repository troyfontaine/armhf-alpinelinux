setup() {
  docker history troyfontaine/armhf-alpinelinux:3.5 >/dev/null 2>&1
}

@test "version is correct" {
  run docker container run troyfontaine/armhf-alpinelinux:3.5 cat /etc/os-release
  [ $status -eq 0 ]
  [ "${lines[2]}" = "VERSION_ID=3.5.2" ]
}

@test "package installs cleanly" {
  run docker container run troyfontaine/armhf-alpinelinux:3.5 apk add --no-cache openssl
  [ $status -eq 0 ]
}

@test "timezone" {
  run docker container run troyfontaine/armhf-alpinelinux:3.5 date +%Z
  [ $status -eq 0 ]
  [ "$output" = "UTC" ]
}

@test "apk-install script should be missing" {
  run docker container run troyfontaine/armhf-alpinelinux:3.5 which prep.sh
  [ $status -eq 1 ]
}

@test "repository list is correct" {
  run docker container run troyfontaine/armhf-alpinelinux:3.5 cat /etc/apk/repositories
  [ $status -eq 0 ]
  [ "${lines[0]}" = "http://dl-cdn.alpinelinux.org/alpine/v3.5/main" ]
  [ "${lines[1]}" = "http://dl-cdn.alpinelinux.org/alpine/v3.5/community" ]
  [ "${lines[2]}" = "" ]
}

@test "cache is empty" {
  run docker container run troyfontaine/armhf-alpinelinux:3.5 sh -c "ls -1 /var/cache/apk | wc -l"
  [ $status -eq 0 ]
  [ "$output" = "0" ]
}

@test "root password is disabled" {
  run docker container run --user nobody troyfontaine/armhf-alpinelinux:3.5 su
  [ $status -eq 1 ]
}
