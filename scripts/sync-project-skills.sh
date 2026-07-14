#!/bin/sh

set -eu

usage() {
  echo "Usage: $0 [--claude] <project-root>" >&2
  exit 64
}

include_claude=false

if [ "${1:-}" = "--claude" ]; then
  include_claude=true
  shift
fi

[ "$#" -eq 1 ] || usage

project_root=$1
[ -d "$project_root" ] || {
  echo "Project root does not exist: $project_root" >&2
  exit 66
}

script_dir=$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd -P)
repo_root=$(CDPATH='' cd -- "$script_dir/.." && pwd -P)
skills_root="$repo_root/skills"
project_root=$(CDPATH='' cd -- "$project_root" && pwd -P)

created=0
unchanged=0
skipped=0
stale=0

sync_dir() {
  target_dir=$1
  mkdir -p "$target_dir"

  for skill_dir in "$skills_root"/*; do
    [ -d "$skill_dir" ] || continue
    [ -f "$skill_dir/SKILL.md" ] || continue

    skill_name=${skill_dir##*/}
    destination="$target_dir/$skill_name"

    if [ -L "$destination" ]; then
      current_target=$(readlink "$destination")
      if [ "$current_target" = "$skill_dir" ]; then
        unchanged=$((unchanged + 1))
      else
        echo "SKIP: $destination is a symlink to $current_target" >&2
        skipped=$((skipped + 1))
      fi
    elif [ -e "$destination" ]; then
      echo "SKIP: $destination already exists and is project-owned" >&2
      skipped=$((skipped + 1))
    else
      ln -s "$skill_dir" "$destination"
      echo "LINK: $destination -> $skill_dir"
      created=$((created + 1))
    fi
  done

  for destination in "$target_dir"/*; do
    [ -L "$destination" ] || continue
    current_target=$(readlink "$destination")
    case "$current_target" in
      "$skills_root"/*)
        if [ ! -f "$destination/SKILL.md" ]; then
          echo "STALE: $destination -> $current_target" >&2
          stale=$((stale + 1))
        fi
        ;;
    esac
  done
}

sync_dir "$project_root/.agents/skills"

if [ "$include_claude" = true ]; then
  sync_dir "$project_root/.claude/skills"
fi

echo "DONE: created=$created unchanged=$unchanged skipped=$skipped stale=$stale"
