# AGENTS.md

## Start of session
At the start of every session, read these files in this order:
1. This file (AGENTS.md) — you're reading it now
2. progress.md — current state, known issues, what's next
3. sprint_log.md — session conventions, sprint plan, daily log

Do not start working until you have read all three.
After reading, check today's date against the sprint plan in sprint_log.md
to determine what day of the sprint this is and what the plan calls for.

Session flow:
1. Read the three files above
2. Determine what sprint day it is and what the plan says to do
3. Generate the day's checklist (see sprint_log.md session conventions)
4. Work through the day's tasks, doing real-time coaching callouts throughout
5. At end of day: update sprint_log with the day's log entry (including "Levels practiced" section), update progress.md, if tooling or workflow changed update docs/human_guide.md, ask Wendy to confirm, then generate Slack check-in

## What this project is
talk_prep is a private, local CLI tool that ingests braindump writing and
organizes ideas into a structured talk outline. All LLM processing happens
on-device via Ollama — no content ever leaves the machine.

## Where to find things
Read the files listed below based on when you need them:

| File | What's in it | When to read |
|---|---|---|
| **AGENTS.md** (this file) | Constraints, stack, current phase | Every session — read first |
| **progress.md** | Current state, known issues, what's next | Every session — read second |
| **sprint_log.md** | Session conventions, sprint plan, daily log | Every session — read third |
| **docs/product_vision.md** | Feature descriptions, input formats | When building a new feature |
| **docs/framework.md** | Source articles, level definitions, level-up criteria, principles | During re-evaluation checkpoints (every 3-4 days) |
| **docs/mcp_notes.md** | MCP decision and rationale | When a capability gap appears |
| **docs/human_guide.md** | Tool setup, how to start a session, what to expect | For Wendy — update this if tooling or workflow changes |
| **docs/daily_log_days_1_7_archive.md** | Days 1-7 daily log entries | Only if you need historical context from early sprint |

## Hard constraints
- NEVER make HTTP calls to external APIs. All LLM calls go to Ollama at
  localhost:11434 via req_llm. If you're not sure, ask.
- Do not add dependencies without being asked. Check mix.exs before
  suggesting a new library.
- Do NOT use git worktrees. Work directly in the main repo (~/Projects/talk_prep).
  Worktrees caused confusion about where files landed (Days 8 and 10).

## What "done" means
Code changes must pass `mix compile` and `mix test` before being considered done.
Do not commit unless asked.

## Stack
- Elixir / Mix / OTP
- req_llm ~> 1.7 (LLM HTTP client)
- Ollama (local LLM server, http://localhost:11434)

## CLI
- `mix braindump <path/to/file.txt>` — processes a braindump and prints structured output
- `./verify.sh` — full quality gate (compile + test + credo). Pass `--strict` to fail on any credo issue.

## Current sprint phase
We are building features as Level 6 (harness engineering) rep cycles. Each rep:
1. Design harness — write feature contract in AGENTS.md (input/output shape, constraints, done criteria), write test stubs, update verify.sh if needed
2. Agent builds inside the harness — runs verify.sh, interprets failures, self-corrects
3. Walk-away test — agent works autonomously on the task
4. Evaluate — what did the harness catch? What did it miss?
5. Tighten — fix harness gaps (add tests, strengthen constraints, improve verify.sh)
6. Adversarial review — fresh session critiques the feature cold

**Next feature: Socratic questioner** (Days 12-16)
When a topic or claim in a braindump lacks supporting evidence, ask the user
leading questions to draw it out. Store answers for later use. Core constraint
still applies: never invent, only organize — questions help the user surface
their own knowledge. See docs/product_vision.md for full description.

## Current output shape
BraindumpProcessor.process/1 returns:
```
%{
  raw: "original text",
  themes: ["theme1", "theme2"],
  topics: [
    %{
      topic: "label",
      needs_points: true | false,
      points: [
        %{point: "statement", details: ["example1", "example2"]}
      ]
    }
  ]
}
```

## Known issues (Ollama/Qwen)
- Topic labels tend to be Qwen's phrasing, not the speaker's verbatim words
- needs_points currently always returns false
- Output shape can vary between runs — Qwen is non-deterministic
- Complex prompts require receive_timeout: 300_000 for larger inputs

## Code notes
- BraindumpValidator exists but is not wired into the pipeline yet.
- FileIngestor has only read_file/1 — placeholder process_file/1 was removed on Day 8.
