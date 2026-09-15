# The route with no server

If you do not want to rent a server, or your one job only needs to run while your laptop is open, you can run the whole thing on your Mac. The trade is simple: it is free, and it stops when the lid closes.

## What it looks like

- Claude Code (or Codex) runs in a terminal window on your Mac and stays open.
- The same `workspace/` files are its instructions: point it at the folder and tell it to read `AGENTS.md` first.
- Telegram: Claude Code has "channels", a way to message a running session from Telegram, Discord, or iMessage. As of September 2026 it is a research preview. Messages you send while the session is closed are lost, not queued. The official page is https://code.claude.com/docs/en/channels; check it before relying on this.
- Schedules: Claude Code has scheduled tasks that run a prompt on a timer. Good for a morning brief. Not good for anything that needs to fire many times a day or react to events. Ask your coding agent to check the current docs for the limits.

## When to pick this

- You want to try the idea for a week before paying for a server
- The job is "when I open my laptop, tell me what changed"
- You are on a subscription and would rather not manage an API key

## When not to

- Anything that must happen at 7am with the lid closed
- Anything that watches for events all day
- Anything you want to text at midnight and get an answer

## The four steps, for your coding agent

1. Copy `workspace/` to a folder on the Mac, interview the human for the six files exactly as in SETUP.md phase 4, and start a Claude Code session in that folder with "read AGENTS.md first" as the standing instruction. Check: the three probes from README step 5 answer from the files.
2. Telegram: follow the current channels page at https://code.claude.com/docs/en/channels. The bot token goes into the channel config the docs name, never into a workspace file. Check: a message from the human's phone reaches the session and gets a reply; the human's Telegram ID is the only one allowed.
3. Routine: use Claude Code's scheduled tasks for the one job in ROUTINE.md, and make its last step write today's date to `workspace/state/last-routine.txt`. Check: run it once; the file has today's date.
4. Health check: `scripts/health-check.sh` works on a Mac too (it uses `lsof` when `ss` is missing). Run it by hand once a week. The gateway lines will say RED on this route, which is expected: there is no gateway. Check: the heartbeat and secret lines are GREEN.

## Moving to a server later

Copy the `workspace/` folder. Follow README steps 1 and 2. The agent is the folder; it will be the same agent on the server.
