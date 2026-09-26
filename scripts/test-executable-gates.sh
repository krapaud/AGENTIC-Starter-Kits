#!/usr/bin/env bash
set -euo pipefail

root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"

for kit in codex claude; do
  hidden=".$kit"
  source_config="$root/starter-kit-$kit/$hidden"
  test_root="$(mktemp -d)"
  trap 'rm -rf "$test_root"' EXIT
  config="$test_root/$hidden"
  mkdir -p "$config/scripts" "$config/work-items/demo"
  cp "$source_config/scripts/validate-obligations.sh" "$config/scripts/"
  cp "$source_config/templates/obligation-register.tsv" "$config/work-items/demo/obligations.tsv"
  cp "$source_config/templates/work-item.md" "$config/work-items/demo/brief.md"
  perl -0pi -e 's/\| Statut \| proposed \|/| Statut | in-progress |/' "$config/work-items/demo/brief.md"

  if bash "$config/scripts/validate-obligations.sh" --if-present >/dev/null 2>&1; then
    echo "ECHEC TEST: le registre pending aurait dû bloquer $kit"
    exit 1
  fi

  perl -0pi -e 's/\tpending\tnot-collected\t/\tverified\ttest-evidence\t/g' "$config/work-items/demo/obligations.tsv"
  bash "$config/scripts/validate-obligations.sh" --require-active >/dev/null

  perl -0pi -e 's/\tverified\ttest-evidence\t/\tverified\tnot-collected\t/' "$config/work-items/demo/obligations.tsv"
  if bash "$config/scripts/validate-obligations.sh" --require-active >/dev/null 2>&1; then
    echo "ECHEC TEST: une preuve absente aurait dû bloquer $kit"
    exit 1
  fi

  rm -rf "$test_root"
  trap - EXIT
done

echo "Tests des portes exécutables OK"
