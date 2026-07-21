#!/usr/bin/env bash

set -euo pipefail

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
checker="$script_dir/check-portability.sh"
fixture_dir=$(mktemp -d "${TMPDIR:-/tmp}/spacemacs-portability.XXXXXX")
trap 'rm -rf "$fixture_dir"' EXIT

assert_passes() {
  local name=$1
  local content=$2
  local fixture="$fixture_dir/$name"

  printf '%s\n' "$content" > "$fixture"
  "$checker" "$fixture" >/dev/null
}

assert_fails() {
  local name=$1
  local content=$2
  local fixture="$fixture_dir/$name"

  printf '%s\n' "$content" > "$fixture"
  if "$checker" "$fixture" >/dev/null 2>&1; then
    printf 'Expected portability check to reject %s\n' "$name" >&2
    exit 1
  fi
}

assert_passes safe.el '(setq example-directory (expand-file-name "notes" "~"))'
assert_fails mac-home.el '(setq notes "/Users/example/notes")'
assert_fails linux-home.el '(setq notes "/home/example/notes")'
assert_fails cellar.el '(setq erl "/opt/homebrew/Cellar/erlang/27.0/bin/erl")'
assert_fails internal-domain.el '(setq proxy "https://code.miyachat.com")'
assert_fails private-network.el '(setq proxy "http://192.168.1.10:3000")'
assert_fails erlang-cookie.el '(setq derl-cookie "not-a-real-cookie")'

printf 'Portability check tests passed.\n'
