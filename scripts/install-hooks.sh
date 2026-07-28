#!/bin/sh
# Install this repo's git hooks (they live in hooks/, which git does not use by default).
set -eu
root=$(git rev-parse --show-toplevel)
for h in "$root"/hooks/*; do
  name=$(basename "$h")
  ln -sfn "../../hooks/$name" "$root/.git/hooks/$name"
  echo "installed: .git/hooks/$name -> ../../hooks/$name"
done
