# ROUTINE.md

This is not an OpenClaw file. Your helper reads it and creates the scheduled automation from it.

One routine. Add a second only after this one has run green for a week.

## {{ROUTINE_NAME}}

- When: {{TIME}} {{TIMEZONE}}, {{every day / weekdays / Sundays}}
- Model: the cheap one
- Do: {{THE_ONE_JOB_IN_TWO_OR_THREE_STEPS}}
- Send: {{a Telegram message under 100 words / a file in inbox/ / both}}
- Last step, always: write today's date to `state/last-routine.txt`. That is the heartbeat.
- If anything fails: still write the heartbeat file with the word FAILED and one line why, and send that line to Telegram.
