# Human Guide

Quick reference for Wendy — what to open, what to type, what to expect.

## Tool setup

| Tool | When |
|---|---|
| Claude Code CLI (Sonnet) | Daily sessions — planning, building, evaluating, everything |
| VS Code | Open alongside to read code and review diffs |
| Claude Code Desktop (Opus) | Only for deep strategic thinking — like the Day 10 plan restructure |

## Starting a new day

1. Open a terminal in `~/Projects/talk_prep`
2. Run `claude` to start Claude Code CLI
3. Type: `Read AGENTS.md and follow the start-of-session instructions.`
4. The agent will read the three core files, figure out what sprint day it is, and generate your checklist

## What to expect during a session

- Agent generates a day checklist at the start
- During builds, agent calls out Level 3-6 behaviors and anti-patterns in real time
- At end of day: agent updates sprint_log and progress.md, asks you to confirm, then generates a Slack check-in

## Terminal setup

Two terminals:
1. Claude Code CLI (the agent)
2. Manual commands (mix, iex, git, verify.sh)

VS Code open alongside for reading code.

## Customization (optional, ~5 min)

Change your terminal font/theme for CLI comfort if the default feels too sterile.
