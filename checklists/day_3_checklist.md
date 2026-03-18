# Day 3 — Context engineering experiments

**Goal:** Build the instinct for context — too little, too much, just right

- Run the deferred experiment: ask Aider to recreate the braindump processor module *without* AGENTS.md in context. Note what breaks or drifts.
- Strengthen AGENTS.md verification language: rewrite the "done means" section using constraint language, not suggestion language. The agent must run `mix compile` and `mix test` before declaring done.
- Run the too-little-context experiment: strip AGENTS.md to just the stack section, ask Aider to add a second module, note the failure modes.
- Run the too-much-context experiment: load AGENTS.md with every detail you can think of, ask the same task, note whether the agent improves or gets confused.
- Find the sweet spot: cut everything from AGENTS.md that the experiments showed the agent doesn't actually use.
- Commit the improved AGENTS.md and log what you cut and why in sprint_log.md.

**Stretch goal if time allows:**
- Write one sentence at the top of AGENTS.md that captures what this repo is for and what "done" looks like — short enough to read aloud in five seconds.

Today produces observations and a better AGENTS.md, not new code. The instinct to develop: "If I removed this line, would the agent's output get worse?" If no — cut it.
