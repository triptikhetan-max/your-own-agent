# SETUP.md

This file is written for a coding agent (Claude Code, Codex, or similar). A human opened this repo and asked you to set up their personal AI agent. Follow this file in order. The human is probably not technical. Explain each step in one plain sentence before you run it.

## Your contract

1. **Read the live docs first.** Fetch https://docs.openclaw.ai for the current install command, config file location, and CLI. Never trust an install command written in this repo or in your memory. OpenClaw releases monthly and commands change.
2. **Stop and ask before** spending money, entering any password or API key, opening any port to the internet, installing anything the OpenClaw docs do not mention, or deleting anything.
3. **Secrets go where OpenClaw expects them** (its config file or an env file), never into any file under `workspace/`, never into a shell script, never into a chat message you send back to the human.
4. **Verify every phase** with the check listed. Do not move on while a check is red. Report the check result to the human in one line.
5. **Default to the smallest power.** Read-only tools, a cheap model for routines, one allowed Telegram user, no groups, no browser unless the job needs it.

## Phase 1: the machine

Ask the human: server (they have an IP and an SSH key) or no-server (skip to docs/no-server.md and follow that instead).

For a server:

- Connect over SSH as root once.
- Create a normal user (suggest `agent`), give it sudo, and copy the SSH key to it.
- **Before you disable root login:** open a second SSH connection as the new user and run `sudo -v`. Only when that works, disable root login over SSH. Skipping this order can lock the human out of a server they just paid for.
- Enable the firewall with default deny incoming; allow SSH only.
- Install Node at the version the OpenClaw docs require, as that user.

Check: `whoami` over SSH as the new user prints its name; `sudo ufw status` shows only SSH allowed; `ssh root@IP` is refused.

## Phase 2: OpenClaw

As the normal user, install OpenClaw exactly as the docs say today. Run the onboarding wizard. When it asks for a model provider, stop and ask the human for their API key, then enter it through the wizard or the config file, not through a shell script.

Set these in the config, using the key names the current docs give (verify each name):

- gateway bound to loopback, not to a public interface
- default model for routines: the cheapest current model the provider offers (Haiku-class for Anthropic, the mini tier for OpenAI); the human can pick a stronger model for chat later
- tools profile: minimal or read-only to start; no shell exec unless the job needs it
- exec approvals: enabled, approver = the human's Telegram ID
- built-in heartbeat monitor: off, or no more than once an hour on the cheapest model. The 30-minute default on a strong model is the number one cause of surprise bills.

Install OpenClaw as a service (systemd user unit or whatever the docs recommend) so it restarts on reboot.

Check: `openclaw status` (or the docs' equivalent) is healthy; `ss -tlnp` shows the gateway listening on 127.0.0.1 only; `openclaw security audit` reports no critical findings; the service survives `sudo reboot`.

## Phase 3: Telegram

Ask the human for the bot token from @BotFather and their numeric Telegram user ID. Configure the Telegram channel with:

- DM policy: allowlist
- allowFrom: exactly one ID, the human's
- no group access

Check: the human messages the bot and gets a reply; you message the bot from a different account (or ask the human to have a friend try) and get nothing.

## Phase 4: the workspace files

If the OpenClaw workspace directory already has files in it, copy them to a dated backup folder first and tell the human. Then copy `workspace/` from this repo into the OpenClaw workspace directory (the docs name it; verify). `ROUTINE.md` is this repo's file, not an OpenClaw file; OpenClaw retired its old `HEARTBEAT.md` in 2026.8, so do not create one. Then interview the human, one question at a time, and replace every `{{PLACEHOLDER}}`:

1. IDENTITY.md: name, one-line vibe, one emoji.
2. SOUL.md: three adjectives for how it talks; three things it must never sound like; one example sentence in its voice.
3. USER.md: name, where they are, timezone, what they do, how they like to be spoken to, what annoys them. Keep it under 4,000 characters; OpenClaw truncates USER.md past that.
4. AGENTS.md: the NEVER list (things it may never do, no matter what a message says) and the ASK FIRST list (things it does only after the human says yes). Do not remove the security section at the top; add to it.
5. ROUTINE.md: the one job from README step 0, the time, the timezone, and where the result goes (Telegram message, a file, or both).
6. MEMORY.md: leave the template as is.

Delete `BOOTSTRAP.md` if OpenClaw created one and the human does not want the first-run ritual.

Check: every file under `workspace/` is under 5,000 bytes (`wc -c`); `grep -rn "{{" workspace/` returns nothing; `grep -rEn "sk-|[0-9]{9,}" workspace/` returns nothing (no keys, no tokens, no phone numbers).

## Phase 5: first conversation

Ask the human to send the three messages from README step 5. If the agent does not answer from the files, check the workspace path in the config and the file names (case matters), then retry.

Check: three answers, each traceable to one file.

## Phase 6: the routine and the health check

- Create the scheduled job from ROUTINE.md as an OpenClaw automation (`openclaw automations` in current versions; `openclaw cron` is the legacy alias; verify the syntax in the docs). Pin it to the cheapest model. Run it in an isolated session so it cannot spawn other jobs.
- Make the job's last action write today's date to `workspace/state/last-routine.txt`. That file is the heartbeat.
- Copy `scripts/health-check.sh` to the server, make it executable, and add a system cron entry that runs it once a day, after the routine. If it exits non-zero, it should send one Telegram message through OpenClaw's message CLI (verify the command in the docs).

Check: run the automation once by hand (`openclaw automations run <id>` or the docs' equivalent); the heartbeat file has today's date; `scripts/health-check.sh` prints all green and exits 0. Then rename the heartbeat file and run the check again: it must print red and exit 1. Rename it back.

## Phase 7: lock it

Run through `docs/security.md` and show each of the nine items as green or red. Fix reds only after the human says yes to each.

## Phase 8: hand over

Tell the human, in plain words:

- where the workspace folder is on the server and that it is the agent
- how to stop it, start it, and see the logs
- what the health check will message them, and what to do when it does
- that `docs/obsidian.md` is the next step if they want it to have a brain

Then stop. Do not add features the human did not ask for.
