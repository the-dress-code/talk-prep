# What is a "long" session?

A Claude Code session starts fresh each time. At the start, the agent reads
the three core files (AGENTS.md, progress.md, sprint_log.md) and has full
context. As the session goes on, that context gets diluted — the conversation
grows, more files get read, more back-and-forth accumulates.

## Signs a session is getting long

- The agent starts contradicting documented decisions
- The agent reasons from assumption rather than from what it read
- The agent stops citing files and starts asserting confidently
- You find yourself redirecting the agent back to the docs

## Practical heuristic

If a session has covered more than 2-3 distinct topics with multiple file
reads each, it's long enough to be careful. Today's Day 13 session is a good
example — 8+ files read, multiple topics (housekeeping, DRY audit, checklist
format, walk-away test, meta discussion), several hours of work.

## What to do about it

- **Shorter sessions help.** Each session starts fresh with a full file read.
  Shorter sessions mean less dilution.
- **Break cleanly.** When a session gets long, write a handoff note with key
  facts while context is still reliable. Start a fresh session for end-of-day
  docs or remaining work.
- **Day n.5 sessions.** Housekeeping and meta work (fixing conventions,
  updating constraints) can live in their own session separate from the main
  build session. This keeps build sessions focused and shorter.
