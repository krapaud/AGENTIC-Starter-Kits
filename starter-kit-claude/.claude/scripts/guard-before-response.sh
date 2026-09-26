#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
state="$(cd "$script_dir/.." && pwd)/RUNTIME-STATE.md"

fail() { echo "GARDE REPONSE: $*" >&2; exit 1; }
[ -f "$state" ] || fail "RUNTIME-STATE.md absent"
value() { sed -n "s/^-[[:space:]]*$1:[[:space:]]*//p; s/^$1:[[:space:]]*//p" "$state" | head -n 1; }
status="$(value execution_status)"; next="$(value next_action)"; open="$(value open_checklist_items)"; evidence="$(value last_observable_evidence)"
case "$status" in
  complete) [[ "$next" =~ ^(none|aucune|aucun)$ ]] || fail "next_action reste ouverte: $next"; [[ "$open" =~ ^(0|none|aucune|aucun)$ ]] || fail "open_checklist_items non nul: $open"; [[ -n "$evidence" && "$evidence" != *"A_COMPLETER"* ]] || fail "last_observable_evidence absente" ;;
  needs-review|blocked) [[ -n "$evidence" && "$evidence" != *"A_COMPLETER"* ]] || fail "preuve obligatoire absente pour $status" ;;
  running|waiting-ci) fail "état non terminal: $status" ;;
  *) fail "execution_status absent ou invalide: ${status:-absent}" ;;
esac
echo "Garde réponse OK: état terminal $status"
