setup() {
  docker history "troyfontaine/armhf-alpinelinux:edge" >/dev/null 2>&1
}

@test "ARM Edge version is correct" {
  run docker container run --rm troyfontaine/armhf-alpinelinux:edge cat /etc/os-release
  [ $status -eq 0 ]
  [ "${lines[2]}" = "VERSION_ID=3.6.0" ]
}

@test "ARM Edge package installs cleanly" {
  run docker container run --rm troyfontaine/armhf-alpinelinux:edge apk add --update openssl
  [ $status -eq 0 ]
}

@test "ARM Edge timezone" {
  run docker container run --rm troyfontaine/armhf-alpinelinux:edge date +%Z
  [ $status -eq 0 ]
  [ "$output" = "UTC" ]
}

@test "ARM Edge repository list is correct" {
  run docker container run --rm troyfontaine/armhf-alpinelinux:3.6 cat /etc/apk/repositories
  [ $status -eq 0 ]
  [ "${lines[0]}" = "http://dl-cdn.alpinelinux.org/alpine/v3.6/main" ]
  [ "${lines[1]}" = "http://dl-cdn.alpinelinux.org/alpine/v3.6/community" ]
}

@test "ARM Edge cache is empty" {
  run docker container run --rm troyfontaine/armhf-alpinelinux:edge sh -c "ls -1 /var/cache/apk | wc -l"
  [ $status -eq 0 ]
  [ "$output" = "0" ]
}

@test "ARM Edge root password is disabled" {
  run docker container run --rm --user nobody troyfontaine/armhf-alpinelinux:edge su
  [ $status -eq 1 ]
}
