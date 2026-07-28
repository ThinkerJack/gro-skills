#!/bin/sh
# Check every downstream repo for drift against this Gro Skills checkout.
#
# A repo is "downstream" if it has a .gro-skills.json at its root.
# Scans ~/Documents/GitHub by default; override with GRO_SCAN_ROOT.
#
#   scripts/check-all.sh          report drift, exit 1 if any
#   scripts/check-all.sh --sync   re-sync every repo that has drifted
#
# Why this exists: the previous setup drifted silently for two weeks because
# nothing ever ran --check. Run this from a git hook or before releasing
# skill changes.

set -eu

script_dir=$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd -P)
repo_root=$(CDPATH='' cd -- "$script_dir/.." && pwd -P)
scan_root=${GRO_SCAN_ROOT:-"$HOME/Documents/GitHub"}
sync_mode=false

[ "${1:-}" = "--sync" ] && sync_mode=true

[ -d "$scan_root" ] || {
  echo "check-all: scan root not found: $scan_root" >&2
  exit 66
}

# Warn early: a dirty source means downstream syncs would embed uncommitted work.
dirty=$(git -C "$repo_root" status --porcelain -- skills | wc -l | tr -d ' ')
if [ "$dirty" -gt 0 ]; then
  echo "check-all: warning — $dirty uncommitted change(s) under skills/"
fi

total=0
drifted=0
synced=0

# maxdepth 3 covers <org>/<repo> layouts without walking node_modules etc.
for cfg in $(find "$scan_root" -maxdepth 3 -name '.gro-skills.json' -not -path '*/node_modules/*' 2>/dev/null | sort); do
  project=$(dirname "$cfg")
  name=${project#"$scan_root"/}
  total=$((total + 1))

  if python3 "$script_dir/sync.py" "$project" --check >/dev/null 2>&1; then
    printf '  ok      %s\n' "$name"
    continue
  fi

  drifted=$((drifted + 1))
  if [ "$sync_mode" = true ]; then
    if python3 "$script_dir/sync.py" "$project" >/dev/null 2>&1; then
      printf '  synced  %s\n' "$name"
      synced=$((synced + 1))
    else
      printf '  FAILED  %s\n' "$name" >&2
    fi
  else
    printf '  DRIFT   %s\n' "$name"
    python3 "$script_dir/sync.py" "$project" --check 2>&1 | sed -n 's/^  - /            /p'
  fi
done

echo
if [ "$sync_mode" = true ]; then
  echo "check-all: $total repo(s), $synced re-synced"
  exit 0
fi

if [ "$drifted" -eq 0 ]; then
  echo "check-all: $total repo(s), all in sync"
  exit 0
fi

echo "check-all: $total repo(s), $drifted drifted — run 'scripts/check-all.sh --sync' to fix" >&2
exit 1
