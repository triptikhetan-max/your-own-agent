#!/usr/bin/env bash
# health-check-cron.sh: the wrapper cron runs. Fill in the three lines below once, then:
#   crontab -e   ->   0 8 * * * $HOME/.openclaw/bin/health-check-cron.sh
export WORKSPACE="${WORKSPACE:-$HOME/.openclaw/workspace}"   # where the agent's files live (verify in the docs)
export OPENCLAW_GATEWAY_PORT="${OPENCLAW_GATEWAY_PORT:-18789}"  # the gateway port from openclaw.json
export MAX_AGE_HOURS="${MAX_AGE_HOURS:-30}"                    # 80 if the routine runs weekdays only
NOTIFY_CMD=""   # the docs' command to send yourself a Telegram message, e.g. openclaw message send --to <your id> --text
set -u
out=$("$(dirname "$0")/health-check.sh" 2>&1); rc=$?
echo "$out"
if [ "$rc" -ne 0 ] && [ -n "$NOTIFY_CMD" ]; then
  red=$(printf '%s\n' "$out" | grep '^RED' | head -3 | tr '\n' ' ')
  $NOTIFY_CMD "health check RED: $red" >/dev/null 2>&1 || true
fi
exit $rc
