setup() {
  docker history troyfontaine/x86_64-alpinelinux:3.5 >/dev/null 2>&1
}

@test "x86_64 3.5 version is correct" {
  run docker container run --rm troyfontaine/x86_64-alpinelinux:3.5 cat /etc/os-release
  [ $status -eq 0 ]
  [ "${lines[2]}" = "VERSION_ID=3.5.2" ]
}

@test "x86_64 3.5 package installs cleanly" {
  run docker container run --rm troyfontaine/x86_64-alpinelinux:3.5 apk add --no-cache openssl
  [ $status -eq 0 ]
}

@test "x86_64 3.5 timezone" {
  run docker container run --rm troyfontaine/x86_64-alpinelinux:3.5 date +%Z
  [ $status -eq 0 ]
  [ "$output" = "UTC" ]
}

@test "x86_64 3.5 repository list is correct" {
  run docker container run --rm troyfontaine/x86_64-alpinelinux:3.5 cat /etc/apk/repositories
  [ $status -eq 0 ]
  [ "${lines[0]}" = "http://dl-cdn.alpinelinux.org/alpine/v3.5/main" ]
  [ "${lines[1]}" = "http://dl-cdn.alpinelinux.org/alpine/v3.5/community" ]
}

@test "x86_64 3.5 cache is empty" {
  run docker container run --rm troyfontaine/x86_64-alpinelinux:3.5 sh -c "ls -1 /var/cache/apk | wc -l"
  [ $status -eq 0 ]
  [ "$output" = "0" ]
}

@test "x86_64 3.5 root password is disabled" {
  run docker container run --rm --user nobody troyfontaine/x86_64-alpinelinux:3.5 su
  [ $status -eq 1 ]
}
