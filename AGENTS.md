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
5. End-of-day documentation — do all of the following before asking Wendy to confirm:
   - **sprint_log.md** — add today's log entry (goal, completed, key decisions, lessons learned, left off at, levels practiced). Do not overstate or abstract — write what actually happened.
   - **progress.md** — update "What works," "Known issues," "What's next." Ensure test status is accurate (e.g. if stubs are failing, say so).
   - **AGENTS.md** — update the feature contract, sprint phase, or any constraints that changed today.
   - **docs/human_guide.md** — update if tooling or workflow changed.
   - **Consistency check** — before presenting for review, verify: no stale dates, no duplicate content across files, no claims that contradict the current state of the repo, sprint plan reflects what actually happened (not what was originally planned).
   - Present the Day N log entry to Wendy and ask her to confirm before proceeding.
6. Learning review: explain any new concepts from today's session in plain language. Write them to learning/ if not already there. Ask Wendy to explain one back in her own words.
7. Generate Slack check-in

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

**Next feature: Socratic questioner** (Days 11-16)

Read docs/product_vision.md §2 before building this feature.

### Feature contract

**Core constraint:** Never invent, only organize. Questions help the user
surface their own knowledge — the questioner never suggests answers.

**MVP scope:** Mode 2 (single claim) first. Mode 1 (pipeline) after Mode 2 works.

#### Mode 2 — single claim (MVP)
```
mix socratic --claim "some claim string"
```
Directly questions a specific claim. No detection step needed.

#### Mode 1 — pipeline (after MVP)
`mix braindump <file>` processes and prints readable output, then prompts:
"Question any claims? (y/n)". If yes, passes the already-processed map to
the Socratic questioner. No re-processing. Key distinction: supporting
evidence ≠ details — a point can have sub-bullets and still be an unsupported
assertion. Requires a separate LLM call per topic/point to detect unsupported claims.

#### Interaction loop
1. Present claim + first question
2. User answers
3. LLM generates follow-up or pushback based on answer
4. Repeat until user types `done` or `skip`
5. Move to next claim automatically

Exit signals:
- `done` — save current claim's Q&A, move to next claim
- `skip` — skip current claim without saving, move to next
- ctrl+c — save completed claims so far, print filename, exit
- empty answer — re-prompt once, then treat as skip

#### Output shape per claim
```elixir
%{
  claim: "string",
  exchanges: [%{question: "string", answer: "string"}]
}
```

#### Storage
- Location: `sessions/` directory at project root — create it if it doesn't exist
- One JSON file per session, timestamped: `sessions/socratic_YYYY-MM-DDTHH-MM.json`
- All Q&A pairs grouped by claim
- No file written if no claims were completed

#### Done criteria
- `mix socratic --claim "..."` questions a claim end to end
- `done` / `skip` / ctrl+c all behave as specified
- Session file saved to `sessions/` with correct JSON structure
- No file written when session produces no completed claims
- `mix compile` and `mix test` pass

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
