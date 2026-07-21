#!/usr/bin/env bash

set -euo pipefail

repo_root=$(git rev-parse --show-toplevel)
cd "$repo_root"

forbidden_patterns=(
  '/Users/[A-Za-z0-9._-]+/'
  '/home/[A-Za-z0-9._-]+/'
  '/opt/homebrew/Cellar/[^/[:space:]"]+/[^/[:space:]"]+'
  'code[.]miyachat[.]com'
  'xygeek[.]xiaohuxi[.]cn'
  'go-athens[.]miyachat[.]com'
  '192[.]168[.][0-9]+[.][0-9]+'
  '[(]setq[[:space:]]+derl-cookie[[:space:]]+"[^"]+"[)]'
  '@[A-Za-z0-9._-]+[.]local'
)

scan_file() {
  local file=$1
  local pattern

  [[ -f "$file" ]] || return 0

  for pattern in "${forbidden_patterns[@]}"; do
    if LC_ALL=C grep -En "$pattern" "$file"; then
      return 1
    fi
  done
}

failed=0

if (( $# > 0 )); then
  for file in "$@"; do
    if ! scan_file "$file"; then
      failed=1
    fi
  done
else
  while IFS= read -r -d '' file; do
    case "$file" in
      openspec/*|layers/lang/my-erlang/local/*|local/user-settings.el)
        continue
        ;;
    esac

    if ! scan_file "$file"; then
      failed=1
    fi
  done < <(git ls-files -z --cached --others --exclude-standard -- \
    init.el 'layers/**' README.md 'docs/**' local/README.md \
    local/user-settings.example.el)
fi

if (( failed != 0 )); then
  printf 'Portability check failed.\n' >&2
  exit 1
fi

printf 'Portability check passed.\n'
