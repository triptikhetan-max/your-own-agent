# What six months taught me

Five rules. Everything else in this repo follows from them.

## 1. The files are the agent

The running process is replaceable. I have moved between OpenClaw versions, changed models, and rebuilt the server. The folder of markdown files came along each time and the agent was the same agent. So: back up the folder, keep it small, keep it readable by a human. If you can read it in Obsidian, it is in good shape.

## 2. One agent, not a fleet

Every "team of agents" I have seen, including my own attempts, ends up as one agent with named routines. Two agents writing to one folder fight. Give the one agent named jobs (the morning brief, the nightly filing, the weekly review) and keep one writer.

## 3. Every routine writes a heartbeat, or it does not ship

A scheduled job that stops running looks exactly like a job with nothing to report, so you find out weeks later. My rule: the last step of every job writes today's date to a file, and a separate check reads that file once a day and shouts if it is stale. The check has no AI in it. It is ten lines of shell.

## 4. Draft, then approve

Inside the system it can read, think, file, and message you without asking. Anything that leaves (an email, a post, a reply) waits for one tap from you. The rule exists for the day it reads a page that tells it to email everyone.

## 5. Corrections become rules

When it gets something wrong and you correct it, that correction goes into MEMORY.md as one dated line. Read at every start. This is the whole memory system. It is also why the file must stay small: prune old rules when they stop applying.

## Two habits that keep it alive

- **Sunday, twenty minutes.** Read MEMORY.md and the week's daily logs. Delete what is stale. Move what is durable.
- **Add one power at a time.** A week of green before the next one. I broke this rule twice and paid for it both times.
