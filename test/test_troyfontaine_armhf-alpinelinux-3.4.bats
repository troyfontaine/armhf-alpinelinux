setup() {
  docker history troyfontaine/armhf-alpinelinux:3.4 >/dev/null 2>&1
}

@test "version is correct" {
  run docker run troyfontaine/armhf-alpinelinux:3.4 cat /etc/os-release
  [ $status -eq 0 ]
  [ "${lines[2]}" = "VERSION_ID=3.4.6" ]
}

@test "package installs cleanly" {
  run docker run troyfontaine/armhf-alpinelinux:3.4 apk add --no-cache openssl
  [ $status -eq 0 ]
}

@test "timezone" {
  run docker run troyfontaine/armhf-alpinelinux:3.4 date +%Z
  [ $status -eq 0 ]
  [ "$output" = "UTC" ]
}

@test "apk-install script should be missing" {
  run docker run troyfontaine/armhf-alpinelinux:3.4 which apk-install
  [ $status -eq 1 ]
}

@test "repository list is correct" {
  run docker run troyfontaine/armhf-alpinelinux:3.4 cat /etc/apk/repositories
  [ $status -eq 0 ]
  [ "${lines[0]}" = "http://nl.alpinelinux.org/alpine/v3.4/main" ]
  [ "${lines[1]}" = "http://nl.alpinelinux.org/alpine/v3.4/community" ]
  [ "${lines[2]}" = "" ]
}

@test "cache is empty" {
  run docker run troyfontaine/armhf-alpinelinux:3.4 sh -c "ls -1 /var/cache/apk | wc -l"
  [ $status -eq 0 ]
  [ "$output" = "0" ]
}

@test "root password is disabled" {
  run docker run --user nobody troyfontaine/armhf-alpinelinux:3.4 su
  [ $status -eq 1 ]
}
