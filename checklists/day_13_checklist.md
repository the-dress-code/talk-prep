Here's your Day 13 checklist:

---

**Day 13 — Walk-Away Test: Socratic Questioner** *Goal: Hand the agent a real task, step away, come back and evaluate*

* Housekeeping: Update "rules" for format of daily checklist, explaining list items, audit .md files for bloat
* Review docs/socratic_questioner_contract.md — confirm you're happy with the spec before the agent builds against it
* Open a fresh session (separate window) and hand the agent this task: "Implement the Socratic questioner. Start with `./verify.sh`. Use it as your feedback loop. Do not read source files first."
    - Updated prompt to "Run `./verify.sh` first. Do not read source files yet."
* Step away — this is the walk-away test. Let it run.
* Come back and evaluate: did the agent finish and verify, or surface a clear blocker? Was verify.sh the entry point, or did it read files first?

**Stretch goal if time allows:**

* Run `mix socratic --claim "..."` on a real claim from your talk and see if it produces useful questions

---

The objective is to evaluate the harness, not just get working code. Note what the harness caught and what it missed — that's Day 14's work.

---

*Generated: 2026-04-01*
