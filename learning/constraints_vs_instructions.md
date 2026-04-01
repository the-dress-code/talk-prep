# Constraints vs. instructions

An instruction tells the agent what to do. A constraint makes it impossible to do otherwise.

Instructions get interpreted. An agent told "run verify.sh before reading source files" might decide that reading a file first is fine if it already knows roughly what's wrong. It's not ignoring the instruction — it's deciding the spirit of it is satisfied.

A constraint removes that choice. "Run verify.sh first. Do not read source files yet." written as a hard rule in AGENTS.md is harder to rationalize around than a verbal intention.

## Why this matters

We saw this today. The walk-away test agent read braindump.ex before running verify.sh — not because it was being difficult, but because the instruction to use verify.sh as the entry point wasn't explicit enough to override its default behavior. The fix was turning it into a protocol with numbered steps in AGENTS.md.

## The principle

From the Bassim article: "Defining boundaries works better than step-by-step checklists, since agents fixate on explicit lists."

Constraints work because they define what the agent is not allowed to do, not just what it should do. The absence of a path is stronger than a sign pointing at the right one.

## In practice

- Weak: "You should run verify.sh to check your work"
- Strong: "Run verify.sh first. Do not read source files until the SUMMARY tells you which one to look at."
