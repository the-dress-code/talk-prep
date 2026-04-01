# What is Level 4 — Compounding?

Level 4 is about making each session smarter than the last — not by remembering the conversation, but by writing things down in the right place so the next agent starts with full context automatically.

## The problem it solves

Every Claude Code session starts fresh. It has no memory of yesterday. If you don't codify what you learned, the next session makes the same mistakes and asks the same questions. You end up re-explaining things you already figured out.

## What compounding looks like in practice

You teach the agent something → you write it into AGENTS.md, progress.md, or sprint_log.md → the next session reads those files and already "knows" it.

Example from Day 11: I found that the Socratic questioner feature details only lived in `docs/product_vision.md`, which isn't in the standard read list. A future agent would miss that context. The fix: write the full feature contract into AGENTS.md. Next session picks it up automatically. Gap closed.

## The Level 4 audit (what we did today)

The audit was a live test of whether compounding is working. This session started cold — no hand-holding, just the three core files — and had full operational context: stack, constraints, sprint day, what's next, session conventions. That's evidence the mechanism is working.

## How to know if you're at Level 4

You start a session and the agent already knows things you taught it last week, because you wrote them down properly. You're not re-explaining. You're building on top of what's there.

## How to explain it to someone

"I treat the project files like the agent's long-term memory. Every time I teach it something new, I write it into the repo so the next session starts smarter. Over time the agent needs less hand-holding because the context is already there."
