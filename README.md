# Your own AI agent

I built one in April 2026. It is called TripBot. It lives on a small server, talks to me on Telegram, reads a folder of notes I keep in Obsidian, and runs a few routines every day. People keep asking how I did it. This is how.

This is not a product. It is a starting point. You set it up in one evening, give it one job, and then turn it into whatever you want. Mine started as a LinkedIn reader and is now the thing that runs my grad school life.

**Never done anything like this? Start with the [plain-English version](https://triptikhetan-max.github.io/your-own-agent/) instead.** It has a switch at the top: "explain it like I'm five" or "I know a bit". Same steps, no computer words without a picture. This README is the middle version.

## What you end up with

- An agent that runs 24/7 and that you text from your phone
- A folder of plain text files that *is* the agent: its rules, its voice, what it knows about you
- One scheduled routine, with a health check that tells you when it silently stops
- A security checklist that closes the five ways these things actually go wrong

## What you need

- A Mac. Windows works through WSL, but I have not tested it.
- Claude Code or Codex installed on that Mac. This is the one technical thing you do yourself, and it is one command from their website. Claude Code is included in the $20 a month Claude Pro plan; you do not need the bigger plan.
- A Telegram account.
- A card for a server (about €5 to 6 a month) and an API key from Anthropic or OpenAI. Or skip the server: see [docs/no-server.md](docs/no-server.md).
- One to three hours.

## How this guide works

You type exactly one line into the terminal, in step 3, to start the coding agent. After that, the coding agent types everything. Every step below has two parts: a prompt you paste into Claude Code or Codex, and a decision only you can make.

The coding agent reads [SETUP.md](SETUP.md) in this repo and the live OpenClaw documentation, so the install commands in your setup never go stale. This repo tells the coding agent *what* a good setup looks like and where it must stop and ask you. The docs tell it *how*, today.

Four words you will meet: the *terminal* is the black window already on your Mac. The *coding agent* (Claude Code or Codex) is an AI that uses your computer for you. An *API key* is a long password your agent shows each time it thinks, and each thought costs a fraction of a cent. A *server* is a computer in someone else's building that never turns off.

Read [docs/cost.md](docs/cost.md) and [docs/security.md](docs/security.md) before you start. They are short.

## The eight steps

### 0. Decide the one job

Your decision. Answer this: what would it do on a Tuesday night while you are asleep?

Pick one job where an agent actually matters, meaning something that needs persistence, memory, or a clock. Some that work:

- Every morning at 7, read my calendar feed and tell me what is due in the next three days
- Every night, read the newsletters in a folder and pull out every date into one list
- Once a day, ask me what I read and file my one-line answer into a notes folder

Do not start with "manage my email" or "post for me." Start read-only. Add powers later, one at a time.

Write the job down in one sentence. You will paste it in step 4.

### 1. Get a computer that never sleeps

Your decision: rent a server, or use your own Mac.

A server is a computer in someone else's building that stays on. Hetzner and DigitalOcean both rent one for about €5 a month. Create an account, pick the smallest Ubuntu machine, and add an SSH key when it asks. An SSH key is a door key only your Mac has. If you do not have one, open the terminal, start your coding agent, and say "help me make an SSH key for a new server." It will make one and tell you what to paste.

If you would rather not pay, or your job only needs to run while your laptop is open, read [docs/no-server.md](docs/no-server.md) and skip to step 3.

### 2. Make the Telegram bot

Your decision: the bot's name.

On your phone, open Telegram and message @BotFather. Send `/newbot`, give it a name and a username, and copy the token it gives you. That token is a password. In step 3 the coding agent will give you a one-line command to type it into a locked file on the server; do not paste it into the chat.

Also send `/start` to @userinfobot and note your numeric Telegram ID. The coding agent will allowlist that ID and nothing else, so no one but you can talk to your agent.

### 3. Let the coding agent set up the server

Open Terminal, go to a folder where you keep projects, and get this repo:

```bash
git clone https://github.com/triptikhetan-max/your-own-agent.git && cd your-own-agent && claude
```

(Use `codex` instead of `claude` if you are using Codex.) Then paste:

> Read SETUP.md and set me up. My server IP is ___ and my SSH key is at ___. Ask me before anything that costs money, needs a password, or opens a port to the internet.

The coding agent will install OpenClaw on the server as a normal user, not root, and lock the gateway to the server itself. For the two secrets (your API key and your bot token) it will not ask you to paste them into the chat. It prepares a locked file on the server and gives you one line to run in a second terminal window, where you type the key yourself and nothing is shown on screen. That keeps the secrets out of the chat history.

### 4. Fill the six files

Your decisions, all of them. The coding agent will interview you, but here is what it will ask, so you can think first:

| File | The one question |
|---|---|
| `IDENTITY.md` | What is it called and what is its one-line vibe? |
| `SOUL.md` | How does it talk? Three adjectives and three things it must never sound like. |
| `USER.md` | Who are you, in ten lines? |
| `AGENTS.md` | What may it never do? What may it do only after you say yes? |
| `ROUTINE.md` | When does it check in, and what does it do then? (Your step 0 job goes here.) |
| `MEMORY.md` | Starts empty. It fills this itself. |

The templates are in [workspace/](workspace/). Every file stays under 5 KB. Big files cost money on every message and make the agent worse, not better.

### 5. First conversation

Open Telegram and message your bot. Ask it three things:

1. "Who are you?" It should answer from `IDENTITY.md` and `SOUL.md`, in the voice you chose.
2. "What may you never do?" It should recite `AGENTS.md`. If it hedges, the file is not loading. Tell the coding agent.
3. "What do you know about me?" It should answer from `USER.md` and nothing else.

If all three work, it is alive.

### 6. One routine

Tell the coding agent:

> Set up the routine in ROUTINE.md as a scheduled automation on the cheapest model, and make it write a heartbeat file when it finishes. Then install scripts/health-check.sh to run once a day and message me on Telegram only if something is red.

This is the rule that kept mine alive for six months: every scheduled job writes a heartbeat, or it does not ship. A job that quietly stops looks exactly like a job that has nothing to say, and you only notice weeks later.

### 7. Lock it

Tell the coding agent:

> Run the checklist in docs/security.md and show me each item as green or red before fixing anything.

Then read the list yourself. It is nine lines.

### 8. When it breaks

It will. Three moves, in order:

1. Ask the coding agent to run `scripts/health-check.sh` and read the logs.
2. Ask it to run `openclaw security audit` and to list the automations.
3. Pull the plug: stop the service. Your agent is the folder of files, not the running process. Nothing is lost.

A note on how to ask for help. I am not IT support, and I will not fix your agent for you. What works for me: explain the problem to the coding agent the way you would explain it to a friend. Messy, with typos, with a screenshot of the error. "it was working yesterday and now the telegram thing just spins." If it gets it wrong, say so and try again. It is not a magic wand. It needs to know what you actually want, and that takes a bit of back and forth. Three tries is normal.

## Where it goes from here

The same skeleton becomes different things depending on what you feed it. Mine grew because I gave it a folder of notes to read and write. That is the Obsidian chapter: [docs/obsidian.md](docs/obsidian.md).

- A research partner: it reads your notes, argues with you, and files what it learns
- A study copilot: it reads your course feeds and briefs you every morning
- A writing partner: it drafts in your voice from your own notes, and you approve every send

Whatever you build, keep two rules: it drafts and you send, and every routine has a heartbeat.

## Costs, security, lessons

- [docs/cost.md](docs/cost.md): real monthly numbers, three tiers, and the mistake that makes it ten times more expensive
- [docs/security.md](docs/security.md): the five things that actually go wrong and nine controls, in order
- [docs/lessons.md](docs/lessons.md): what six months of running one taught me
- [docs/recipes.md](docs/recipes.md): eight jobs to add after the first evening, each with the sentence to paste and a repo to borrow from
- [docs/obsidian.md](docs/obsidian.md): giving it a brain
- [docs/no-server.md](docs/no-server.md): the route with no server

## What this is not

This is a skeleton, not a copy of TripBot. TripBot's voice, memory, and rules are mine; the templates here carry placeholders, and you fill them with yours.

I do not support it. I fixed mine when it broke. If a step breaks for you, open an issue and I will look when I can, but the fix is usually "ask the coding agent to read the current OpenClaw docs."

OpenClaw is what I use, but Hermes or a plain Claude Code session in a terminal both work with the same files and rules.

## License

Code and templates: MIT. The guide and docs: CC BY 4.0. Fork it, change everything, keep the credit line.
