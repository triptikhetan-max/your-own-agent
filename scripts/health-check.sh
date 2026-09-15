#!/usr/bin/env bash
# health-check.sh: is the agent alive? No AI involved. Exit 0 = all green, 1 = something red.
# Usage: WORKSPACE=/path/to/workspace ./health-check.sh
set -u
WORKSPACE="${WORKSPACE:-$HOME/.openclaw/workspace}"
HEARTBEAT="$WORKSPACE/state/last-routine.txt"
MAX_AGE_HOURS="${MAX_AGE_HOURS:-30}"
red=0
say() { printf '%s %s\n' "$1" "$2"; }

# 1. gateway process
if pgrep -f "openclaw.*gateway" >/dev/null 2>&1 || (command -v openclaw >/dev/null 2>&1 && openclaw status >/dev/null 2>&1); then say GREEN "gateway process running"; else say RED "gateway process not running"; red=1; fi

# 2. gateway listens on loopback only (port from OPENCLAW_GATEWAY_PORT, default 18789)
PORT="${OPENCLAW_GATEWAY_PORT:-18789}"
if command -v ss >/dev/null 2>&1; then
  listeners=$(ss -tln 2>/dev/null | awk -v p=":$PORT" '$4 ~ p"$" {print $4}')
elif command -v lsof >/dev/null 2>&1; then
  listeners=$(lsof -nP -iTCP:"$PORT" -sTCP:LISTEN 2>/dev/null | awk 'NR>1 {print $9}')
else
  listeners=""; say RED "cannot check the gateway port (no ss or lsof)"; red=1
fi
if [ -z "$listeners" ]; then say RED "nothing listening on the gateway port $PORT (is the gateway running?)"; red=1
elif printf '%s\n' "$listeners" | grep -vqE '^(127\.0\.0\.1|\[::1\]|localhost):'; then say RED "gateway listening on a non-loopback address (port $PORT): $(printf '%s' "$listeners" | tr '\n' ' ')"; red=1
else say GREEN "gateway listening on loopback only (port $PORT)"; fi

# 3. heartbeat file fresh
if [ -f "$HEARTBEAT" ]; then
  age_h=$(( ( $(date +%s) - $(stat -c %Y "$HEARTBEAT" 2>/dev/null || stat -f %m "$HEARTBEAT") ) / 3600 ))
  if [ "$age_h" -le "$MAX_AGE_HOURS" ]; then say GREEN "heartbeat ${age_h}h old"; else say RED "heartbeat ${age_h}h old (max ${MAX_AGE_HOURS})"; red=1; fi
  if grep -q FAILED "$HEARTBEAT"; then say RED "last routine reported FAILED: $(head -1 "$HEARTBEAT")"; red=1; fi
else
  say RED "no heartbeat file at $HEARTBEAT"; red=1
fi

# 4. workspace files small
big=0
for f in "$WORKSPACE"/*.md; do
  [ -f "$f" ] || continue
  if [ "$(wc -c < "$f")" -gt 5000 ]; then say RED "$(basename "$f") over 5 KB"; red=1; big=1; fi
done
[ "$big" -eq 0 ] && say GREEN "workspace files under 5 KB"

# 5. no secrets in workspace
if grep -rEq 'sk-(ant|proj|live)?-?[A-Za-z0-9_-]{16,}|[0-9]{8,}:[A-Za-z0-9_-]{30,}|(ANTHROPIC|OPENAI)_API_KEY=' "$WORKSPACE" --include='*.md' 2>/dev/null; then say RED "possible secret in a workspace file"; red=1; else say GREEN "no secrets in workspace files"; fi

exit $red
