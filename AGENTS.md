# AGENTS.md

### What this project is
talk_prep is a private, local CLI tool that ingests braindump writing and
organizes ideas into a structured talk outline. All LLM processing happens
on-device via Ollama — no content ever leaves the machine.

## Hard constraints
- NEVER make HTTP calls to external APIs. All LLM calls go to Ollama at
  localhost:11434 via req_llm. If you're not sure, ask.
- Do not add dependencies without being asked. Check mix.exs before
  suggesting a new library.
- Do not commit. Your job is to write correct code and stop.

## What "done" means for Aider
Your job is to write correct code and stop. Do not commit.
After you make changes, tell me what you changed and why.
The human will run mix compile and mix test to verify.

## Stack
- Elixir / Mix / OTP
- req_llm ~> 1.7 (LLM HTTP client)
- Qwen qwen2.5-coder:14b via Ollama (local model, http://localhost:11434)