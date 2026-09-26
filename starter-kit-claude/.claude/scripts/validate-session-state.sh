#!/usr/bin/env bash
set -euo pipefail
script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
state="$(cd "$script_dir/.." && pwd)/RUNTIME-STATE.md"
[ -f "$state" ] || { echo "SESSION: RUNTIME-STATE.md absent" >&2; exit 1; }
value() { sed -n "s/^-[[:space:]]*$1:[[:space:]]*//p" "$state" | head -n 1; }
for key in execution_status next_action last_observable_evidence required_action_status pending_request_id pending_turn_id budget_status environment_status session_status; do
  v="$(value "$key")"
  [ -n "$v" ] && [[ "$v" != *A_COMPLETER* ]] || { echo "SESSION: champ absent ou incomplet: $key" >&2; exit 1; }
done
echo "État de session lisible et complet"
