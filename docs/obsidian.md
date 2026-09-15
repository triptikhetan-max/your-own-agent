# Giving it a brain (the Obsidian part)

The agent's brain is a folder of markdown files, and Obsidian is a window onto that folder. There is no database and nothing to buy.

Mine reads a vault of a few hundred notes: what I am studying, who I have met, what I think about things. It writes back to two folders in that vault. Everything else it can read but not change. The vault lives on my Mac in Obsidian and on the server next to the agent, and a sync keeps the two identical.

## The minimum structure

Start with this. Add folders when a folder is obviously missing, not before.

```
brain/
  inbox/        the agent drops things here for you; you file them
  memory/       OpenClaw's daily logs, one file a day, written by the agent
  notes/        your knowledge, filed by you, read by the agent
  people/       one note per person, read by the agent
  projects/     one note per thing you are working on
  _Home.md      a one-screen map of the vault; the agent reads this first
```

Five starter notes that make an immediate difference:

1. `_Home.md`: what each folder is for and the five notes it should read first
2. `notes/how-i-think.md`: how you like to reason and argue, in your words
3. `projects/current.md`: what you are working on this month, dated
4. `people/`: three people it will hear about often
5. `notes/things-i-believe.md`: ten positions, so it can push back with your own arguments

## The rules for the agent (add these to AGENTS.md)

- Read `_Home.md` at the start of any task that needs the vault, then open only the notes it points to. Do not read the whole vault.
- Write to `inbox/` and `memory/`. Append to `projects/`. Never write to `notes/` or `people/` without being asked.
- Never delete. Rename with a date prefix if something is wrong.
- Use `[[wikilinks]]` when you name a note that exists. Do not invent links.

## Syncing the folder

You want the same folder on your Mac (where Obsidian opens it) and on the server (where the agent reads it). Two ways:

**Syncthing** (recommended for most people). A free program that keeps two folders identical over the internet, with no cloud account. Tell your coding agent:

> Install Syncthing on my Mac and on the server, and sync ~/brain on the Mac with the agent's workspace/brain folder on the server. Show me the two device IDs so I can approve the pairing.

**Git** (if you already use it). The vault is a private repository. The agent commits its writes every hour; you pull when you open Obsidian. Slower, but every change is reviewable, and that suits some people.

Do not use iCloud or Dropbox for this folder. They fight with an agent that writes constantly.

## Opening it in Obsidian

Open Obsidian, choose "Open folder as vault", pick `brain/`. That is it. Two settings worth changing: turn on "Show inline title" and set new-note location to `inbox/`, so what you write lands where the agent looks.

## What it grows into

The same skeleton, fed differently:

- **Research partner.** Fill `notes/` with what you are reading. Its nightly routine: read yesterday's `memory/` log, find the three notes it touched, and write one question into `inbox/`.
- **Study copilot.** `projects/` holds your courses. Its morning routine: read the calendar feed, cross-check `projects/`, and message what is due.
- **Writing partner.** `notes/things-i-believe.md` plus `notes/how-i-think.md` are its voice reference. It drafts to `inbox/`; you edit and send. It never posts.

Mine is all three, because I kept feeding it. Start with one.
