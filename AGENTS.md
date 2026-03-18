# AGENTS.md

## What this project is
talk_prep is a private, local CLI tool for conference talk preparation.
It ingests braindump writing and organizes ideas into a structured talk
outline. All processing happens on-device using a local LLM — no content
ever leaves the machine.

## Stack
- Elixir / Mix / OTP
- Jido ~> 2.0 (action pipeline)
- req_llm ~> 1.5 (LLM HTTP client)
- Qwen qwen2.5-coder:14b via Ollama (local model, http://localhost:11434)

## Hard constraints
- NEVER make HTTP calls to external APIs. All LLM calls go to Ollama at
  localhost:11434 via req_llm. If you're not sure, ask.
- Do not add dependencies without being asked. Check mix.exs before
  suggesting a new library.

## What "done" means
A task is done when:
1. `mix compile` produces no errors or warnings
2. `mix test` passes
3. The change is committed with a clear message

Do not declare a task complete until you have run both commands and
confirmed they pass.

## Where things live
- `lib/talk_prep/` — application modules
- `test/` — ExUnit tests
- `AGENTS.md` — this file; your orientation document
- `sprint_log.md` — sprint context for the human; do not modify
- `checklists/` — daily sprint checklists; do not modify
