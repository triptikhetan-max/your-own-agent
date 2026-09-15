# SETUP.md

This file is written for a coding agent (Claude Code, Codex, or similar). A human opened this repo and asked you to set up their personal AI agent. Follow this file in order. The human is probably not technical. Explain each step in one plain sentence before you run it.

## Your contract

0. **Getting this repo does not need git.** If it is not on disk yet, download https://github.com/triptikhetan-max/your-own-agent/archive/refs/heads/main.zip with `curl -L` and unzip it into `~/your-own-agent`. Do not install git or Xcode tools for this.

1. **Read the live docs first.** Fetch https://docs.openclaw.ai for the current install command, config file location, and CLI. Never trust an install command written in this repo or in your memory. OpenClaw releases monthly and commands change.
2. **Stop and ask before** spending money, entering any password or API key, opening any port to the internet, installing anything the OpenClaw docs do not mention, or deleting anything.
3. **Secrets never travel through this chat.** The API key and the bot token go into one root-only env file on the server, and the human types them there. Your job is to prepare the file and print the one line the human runs in a second terminal window (use `read -s` so nothing is echoed). If the human insists on pasting a secret into the chat, write it straight to that file, confirm, and tell them to start a new chat afterward. Never put a secret in any file under `workspace/`, in a shell script, in a crontab, or in a message you send back.
4. **Verify every phase** with the check listed. Do not move on while a check is red. Report the check result to the human in one line.
5. **Default to the smallest power.** Read-only tools, a cheap model for routines, one allowed Telegram user, no groups, no browser unless the job needs it.

## Phase 1: the machine

Ask the human: server (they have an IP and an SSH key) or no-server (skip to docs/no-server.md and follow that instead).

For a server, in exactly this order. Each line is one decision a previous agent got wrong.

1. Ask for the path to the SSH key on the Mac (`~/.ssh/id_ed25519` is the usual answer) and whether it has a passphrase. Connect once as root.
2. Create the user `agent` with no password (`adduser --disabled-password --gecos "" agent`), add it to sudo, and give it passwordless sudo via a file in `/etc/sudoers.d/` checked with `visudo -c`. Do not invent a password.
3. Copy only the **public** key: root's `authorized_keys` into `/home/agent/.ssh/authorized_keys`, owned by `agent`, mode 600. Never copy or read the Mac's private key.
4. Firewall: `ufw allow OpenSSH` **before** `ufw --force enable`, with default deny incoming and allow outgoing. If SSH is on a non-22 port, allow that port instead.
5. **Stop.** In a second SSH session as `agent`, run `whoami && sudo -v && sudo ufw status`. Only when that is green, continue.
6. Disable root and password login with a drop-in file `/etc/ssh/sshd_config.d/99-hardening.conf` containing `PermitRootLogin no` and `PasswordAuthentication no`. On Ubuntu 24.04 check that `50-cloud-init.conf` in the same folder does not override it. Run `sshd -t`, then reload ssh.
7. `loginctl enable-linger agent`, so the user-level service survives a reboot.
8. Install Node at the version the OpenClaw docs require, as `agent`. The Node installer is a download: ask first.

Check: `ssh agent@IP` works; `ssh root@IP` is refused; `sudo ufw status` shows only SSH; `loginctl show-user agent | grep Linger` prints yes.

## Phase 2: OpenClaw

Before installing, ask two things: "Have you set a monthly spending limit on the API key?" (do not continue until yes) and "What is your numeric Telegram user ID from @userinfobot?" (you need it for exec approvals below).

As the normal user, install OpenClaw exactly as the docs say today. For the API key, follow contract rule 3: create `~/.openclaw/secrets.env` (mode 600) and print the one line the human runs in a second terminal to type the key into it, for example `ssh agent@IP 'read -s -p "paste the API key: " k; echo "ANTHROPIC_API_KEY=$k" >> ~/.openclaw/secrets.env; chmod 600 ~/.openclaw/secrets.env'`. Point the service at that file (`EnvironmentFile=`). Run the onboarding wizard non-interactively where the docs allow it, otherwise print the wizard command for the human to run in that same second window.

Set these in the config, using the key names the current docs give (verify each name):

- gateway bound to loopback, not to a public interface
- default model for routines: the cheapest current model the provider offers (Haiku-class for Anthropic, the mini tier for OpenAI); the human can pick a stronger model for chat later
- tools profile: minimal or read-only to start; no shell exec unless the job needs it
- exec approvals: enabled, approver = the human's Telegram ID
- built-in heartbeat monitor: **off**. The one routine in ROUTINE.md is the only scheduled work. The 30-minute default on a strong model is the number one cause of surprise bills.

Install OpenClaw as a service (systemd user unit or whatever the docs recommend) so it restarts on reboot. Linger must already be on from Phase 1, or the user unit will not start after a reboot.

Check: `openclaw status` (or the docs' equivalent) is healthy; `ss -tlnp` shows the gateway listening on 127.0.0.1 only; `openclaw security audit` reports no critical findings; ask the human before `sudo reboot`, then confirm the service came back on its own.

## Phase 3: Telegram

The bot token goes in through the same second-window line as the API key (`TELEGRAM_BOT_TOKEN=` in `secrets.env`, or wherever the docs say the channel reads it). You already have the numeric user ID from Phase 2. Configure the Telegram channel with:

- DM policy: allowlist
- allowFrom: exactly one ID, the human's
- no group access

Check: the human messages the bot and gets a reply; you message the bot from a different account (or ask the human to have a friend try) and get nothing.

## Phase 4: the workspace files

If the OpenClaw workspace directory already has files in it, copy them to a dated backup folder first and tell the human. Then copy `workspace/` from this repo into the OpenClaw workspace directory (the docs name it; verify). `ROUTINE.md` is this repo's file, not an OpenClaw file; OpenClaw retired its old `HEARTBEAT.md` in 2026.8, so do not create one. Then interview the human, one question at a time, and replace every `{{PLACEHOLDER}}`:

1. IDENTITY.md: name, one-line vibe, one emoji.
2. SOUL.md: three adjectives for how it talks; three things it must never sound like; one example sentence in its voice.
3. USER.md: name, where they are, timezone, what they do, how they like to be spoken to, what annoys them. Keep it under 4,000 characters; OpenClaw truncates USER.md past that.
4. AGENTS.md: the NEVER list (things it may never do, no matter what a message says) and the ASK FIRST list (things it does only after the human says yes). Do not remove the security section at the top; add to it. The "never edit" rule in that section binds the agent, not you during setup.
5. ROUTINE.md: the one job from README step 0, the time, the timezone, and where the result goes (Telegram message, a file, or both).
6. MEMORY.md: leave the template as is.

Delete `BOOTSTRAP.md` if OpenClaw created one and the human does not want the first-run ritual.

Check: every file under `workspace/` is under 5,000 bytes (`wc -c`); `grep -rn "{{" workspace/` returns nothing; `grep -rEn "\bsk-[A-Za-z0-9_-]{16,}|[0-9]{9,}" workspace/` returns nothing (no keys, no tokens, no phone numbers).

## Phase 5: first conversation

Ask the human to send the three messages from README step 5. If the agent does not answer from the files, check the workspace path in the config and the file names (case matters), then retry.

Check: three answers, each traceable to one file.

## Phase 6: the routine and the health check

- Create the scheduled job from ROUTINE.md as an OpenClaw automation (`openclaw automations` in current versions; `openclaw cron` is the legacy alias; verify the syntax in the docs). Pin it to the cheapest model. Run it in an isolated session so it cannot spawn other jobs.
- Make the job's last action write today's date to `workspace/state/last-routine.txt`. That file is the heartbeat.
- Set the automation's timezone explicitly to the human's; the server clock is UTC.
- Copy `scripts/health-check.sh` and `scripts/health-check-cron.sh` to `~/.openclaw/bin/` as `agent`, make them executable, and fill in the three variables at the top of the cron wrapper (workspace path, gateway port, the notify command from the docs). Add the wrapper to the `agent` user's crontab once a day, an hour after the routine. If the routine runs weekdays only, set `MAX_AGE_HOURS=80` in the wrapper so weekends do not page.
- Running the routine by hand costs a few cents and sends a message: ask first.

Check: run the automation once by hand (`openclaw automations run <id>` or the docs' equivalent); the heartbeat file has today's date; `scripts/health-check.sh` prints all green and exits 0. Then rename the heartbeat file and run the check again: it must print red and exit 1. Rename it back.

## Phase 7: lock it

Run through `docs/security.md` and show each of the nine items as green or red. Fix reds only after the human says yes to each.

## Phase 8: hand over

Tell the human, in plain words:

- where the workspace folder is on the server and that it is the agent
- how to stop it, start it, and see the logs, as three exact commands they can paste (for a systemd user unit: `systemctl --user stop|start openclaw-gateway` and `journalctl --user -u openclaw-gateway -n 50`, or the docs' equivalents)
- what the health check will message them, and what to do when it does
- that `docs/obsidian.md` is the next step if they want it to have a brain

Then stop. Do not add features the human did not ask for.
