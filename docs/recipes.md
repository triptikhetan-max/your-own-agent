# Recipes: things to build after the first evening

Each recipe is one job. Each one has what it needs, the sentence to paste to your helper, and a public repo to borrow ideas from. Run one for a week before adding the next.

## 1. Morning brief from your calendar

- Needs: a calendar feed link. Google Calendar, Outlook, Canvas, and most school systems give you a private "ICS" link under settings. Copy it. It is a secret too; it goes only to your helper.
- Paste: "Add a morning routine at 7am: read my calendar feed at ___ and text me what is due or happening in the next three days, three bullets max, nothing else."
- Borrow from: [claude-chief-of-staff](https://github.com/mimurchison/claude-chief-of-staff) (a goals file plus a daily "gm" routine).

## 2. Newsletter reader

- Needs: a folder where newsletters land. Easiest: a Gmail filter that forwards newsletters to a label, and a small script your helper writes that saves them as text files into `brain/inbox/newsletters/`.
- Paste: "Every night at 10pm, read any new files in inbox/newsletters, pull out every date and deadline into one dated list in inbox/dates.md, and text me only if something is due within a week."
- Borrow from: [obsidian-second-brain](https://github.com/eugeniughelbur/obsidian-second-brain) (its nightly routine).

## 3. Second brain (text it a thought, it files it)

- Needs: the Obsidian setup in [obsidian.md](obsidian.md). Five starter notes.
- Paste: "When I text you a thought with no question, save it to inbox/ as a new note with today's date and a one-line title, and reply with just the title. Never file it anywhere else."
- Borrow from: [agent-second-brain](https://github.com/smixs/agent-second-brain) (voice first, "you talk, the agent files").

## 4. Reading log

- Needs: nothing.
- Paste: "Every evening at 9pm ask me one question: what did you read today? Save my answer as one line in brain/notes/reading-log.md with the date. If I say nothing, say goodnight and stop."
- Borrow from: [life-system](https://github.com/davidhariri/life-system) (plain files, one journal).

## 5. Study copilot

- Needs: one note per course in `brain/projects/`, with the weekly rhythm and the big dates. Ten lines each.
- Paste: "Every Sunday at 6pm, read brain/projects and text me the week ahead: what is due, what to read, and one thing I am likely to forget. Under 120 words."
- Borrow from: [obsidian-second-brain](https://github.com/eugeniughelbur/obsidian-second-brain) (weekly review).

## 6. Writing partner

- Needs: `brain/notes/how-i-think.md` and `brain/notes/things-i-believe.md` filled in honestly. Two hundred words each.
- Paste: "When I text you 'draft:' followed by a topic, write 150 words in my voice using my notes, save it to inbox/drafts/, and reply with the draft. Never post or send anything."
- Borrow from: [LifeOS](https://github.com/danielmiessler/LifeOS) (a voice file the agent reads before writing).

## 7. Research partner

- Needs: a folder of things you are reading, as text or PDF, in `brain/notes/reading/`.
- Paste: "Every night, read yesterday's memory log, find the notes I touched, and write one question into inbox/questions.md that connects two of them. One question, no answer."
- Borrow from: [agentic-second-brain-guide](https://github.com/bbuch82/agentic-second-brain-guide) (the best description of an agent that reads a vault and argues back).

## 8. Watcher (no AI, just a nudge)

- Needs: a web page or feed you check too often.
- Paste: "Every hour, fetch ___ and compare it to the last copy you saved. If it changed, text me the changed lines. No AI call unless it changed."
- Borrow from: [ella](https://github.com/newmindsgroup/ella-claude-code-ai-agent) (watchers that cost nothing until something happens).

## Repos worth reading, in order

1. [agentic-second-brain-guide](https://github.com/bbuch82/agentic-second-brain-guide): OpenClaw plus Obsidian, one year of running notes, health checks.
2. [LifeOS](https://github.com/danielmiessler/LifeOS): the most complete personal system on Claude Code.
3. [obsidian-second-brain](https://github.com/eugeniughelbur/obsidian-second-brain): four routines over a vault.
4. [agent-second-brain](https://github.com/smixs/agent-second-brain): Claude Code on a $5 server, Telegram, voice.
5. [claude-chief-of-staff](https://github.com/mimurchison/claude-chief-of-staff): Gmail and Calendar, small and sharp.
6. [life-system](https://github.com/davidhariri/life-system): no framework, plain markdown.
7. [agentic-cortex](https://github.com/albert-ying/agentic-cortex): a three-tier memory design, corrections become rules.
8. [hal-os](https://github.com/thebrownproject/hal-os): a tiny "boot and shutdown" memory pattern.
9. [Hermes](https://github.com/NousResearch/hermes-agent): the other runtime, if you want memory size limits built in.

## The rule that applies to every recipe

Read-only first. A recipe that sends, posts, or spends is a recipe you run with "draft it and show me" for a month before you let it act.
