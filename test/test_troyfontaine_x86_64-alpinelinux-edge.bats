setup() {
  docker history "troyfontaine/x86_64-alpinelinux:edge" >/dev/null 2>&1
}

@test "x86_64 Edge version is correct" {
  run docker container run --rm troyfontaine/x86_64-alpinelinux:edge cat /etc/os-release
  [ $status -eq 0 ]
  [ "${lines[2]}" = "VERSION_ID=3.6.0" ]
}

@test "x86_64 Edge package installs cleanly" {
  run docker container run --rm troyfontaine/x86_64-alpinelinux:edge apk add --update openssl
  [ $status -eq 0 ]
}

@test "x86_64 Edge timezone" {
  run docker container run --rm troyfontaine/x86_64-alpinelinux:edge date +%Z
  [ $status -eq 0 ]
  [ "$output" = "UTC" ]
}

@test "x86_64 Edge prep.sh script should be missing" {
  run docker container run --rm troyfontaine/x86_64-alpinelinux:edge which prep.sh
  [ $status -eq 1 ]
}

@test "x86_64 Edge repository list is correct" {
  run docker container run --rm troyfontaine/x86_64-alpinelinux:3.6 cat /etc/apk/repositories
  [ $status -eq 0 ]
  [ "${lines[0]}" = "http://dl-cdn.alpinelinux.org/alpine/v3.6/main" ]
  [ "${lines[1]}" = "http://dl-cdn.alpinelinux.org/alpine/v3.6/community" ]
}

@test "x86_64 Edge cache is empty" {
  run docker container run --rm troyfontaine/x86_64-alpinelinux:edge sh -c "ls -1 /var/cache/apk | wc -l"
  [ $status -eq 0 ]
  [ "$output" = "0" ]
}

@test "x86_64 Edge root password is disabled" {
  run docker container run --rm --user nobody troyfontaine/x86_64-alpinelinux:edge su
  [ $status -eq 1 ]
}
