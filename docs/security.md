# Security

Five things that actually happen, and nine controls in the order that matters.

## The five things that go wrong

1. **Prompt injection.** The agent reads a web page, an email, or a feed that contains instructions. It follows them. This is the big one and it is not solved. The defence is a small rules file it cannot edit, and no power to do damage.
2. **An exposed gateway.** OpenClaw has a web gateway. If it listens on the public internet, anyone who finds it has your agent. Hundreds of these have been found by scanners.
3. **Secrets in files.** A token pasted into a notes file that later gets synced, shared, or pushed to GitHub.
4. **Cost runaway.** A routine on a strong model every 30 minutes. See cost.md.
5. **It overwrites your own files.** An agent with write access and no rule against deleting will, one day, tidy up.

## The nine controls

Run this as a checklist. Tell your coding agent: "show me each one as green or red."

1. **The rules file outranks everything, and the agent cannot edit it.** `AGENTS.md` starts with a security section that says so. Test: ask the agent to change its own rules. It must refuse.
2. **One Telegram user, allowlisted by numeric ID.** Not "pairing", not open. No groups. No unofficial bridges to WhatsApp or iMessage; those get personal accounts banned.
3. **Gateway on loopback only.** It listens on 127.0.0.1, never 0.0.0.0. No port forwarded. Firewall default deny, SSH only, key only, root login off.
4. **Not root.** It runs as a normal user. Exec approvals on. Tools set to the minimum the job needs; no shell unless the job needs a shell.
5. **A separate API key with a monthly cap.** Revoke it in one click if anything looks wrong.
6. **Draft, then approve.** Anything that leaves the system (a message, an email, a post) is a draft until you tap yes. Read-only by default on every external platform.
7. **No powers it does not need.** No email password. No bank. No calendar write. Add one power at a time, after a week of the previous one running clean.
8. **Back up the workspace folder.** It is the agent. The server is disposable. A weekly copy to your Mac is enough.
9. **Small files.** Every workspace file under 5 KB. Big context is expensive and makes injection easier to hide.

Also run `openclaw security audit` once a month. It tells you when you have drifted from the defaults.

## What I got wrong, so you do not

I set mine up fast in April and fixed things as they bit me. In order of how much they mattered:

- I ran it as root for months. One bad command away from losing the box.
- I turned exec approvals off because the prompts were annoying. That is the one control that stops a bad instruction from becoming a bad action.
- I left the tools profile on "full" when the job needed read-only.
- I left the strongest model as the default for everything, including the 30-minute heartbeat. That is where the money went.
- I ran an unofficial WhatsApp bridge for months. It worked, until it did not, and the ban risk was real the whole time.

SETUP.md sets the opposite of each of these as the default.
