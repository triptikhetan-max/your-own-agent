# What it costs

Estimates from running mine since April 2026 plus what other people report. Your numbers will differ. Check your provider's console after the first week.

| Item | Low | Typical | Runaway |
|---|---|---|---|
| Server (Hetzner or DigitalOcean, smallest Ubuntu) | €5 a month | €5 to 6 a month | |
| Model API, cheap model, one routine a day plus some chat | $5 a month | $10 to 20 a month | |
| Model API, strongest model as default, built-in heartbeat every 30 minutes | | $60 to 100 a month | $18 to 36 a day, reported by several people |
| Telegram | free | | |
| Claude Code or Codex on your Mac, used only for setup | $20 a month subscription, or a few cents of API | | |
| No-server route (your Mac stays awake) | $0 server, subscription only | | |
| Your time, first evening | 1 hour | 2 hours | 3 hours |

Rule of thumb: €5 server plus $15 of model is about $20 a month, if routines run on a cheap model.

## The mistake that makes it ten times more expensive

The built-in heartbeat monitor. OpenClaw can wake the agent every 30 minutes to "check in". On a strong model, with big workspace files, that is 48 paid conversations a day that mostly say "nothing to do". I ran mine that way for months. Two fixes, both in SETUP.md:

1. Turn the built-in heartbeat off, or set it to once an hour on the cheap model.
2. Keep every workspace file under 5 KB. The files are sent with every message. A 20 KB rules file is paid for 48 times a day.

## Two things to do before the first routine runs

1. Put a monthly spending limit on the API key in your provider's console. Anthropic and OpenAI both have one.
2. Make a separate API key for the agent, so you can revoke it without touching anything else.
