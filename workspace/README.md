# workspace/

These are the files OpenClaw loads when your agent starts, plus ROUTINE.md, which your helper turns into a scheduled automation. Together they are the agent. Copy this folder to the server, replace every `{{PLACEHOLDER}}`, and keep each file under 5 KB.

| File | What it is |
|---|---|
| AGENTS.md | The rules. The security section at the top outranks everything else. |
| SOUL.md | How it talks. |
| IDENTITY.md | Its name and vibe. |
| USER.md | Who you are. OpenClaw caps this at 4,000 characters. |
| ROUTINE.md | Its one scheduled job, in plain words. Not read by OpenClaw itself. |
| MEMORY.md | What it remembers across sessions. Starts nearly empty. |
