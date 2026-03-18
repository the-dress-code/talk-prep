# Day 2 Checklist — Write AGENTS.md, Feel the Difference Context Makes

**Goal:** Create AGENTS.md for talk_prep and experience firsthand how context
changes agent behavior.

---

## Steps

- [ ] Check what's already in `.gitignore`:
      `cat ~/Projects/talk_prep/.gitignore`
- [ ] Append any missing entries to `.gitignore` (secrets, macOS, editor, aider)
- [ ] Create `AGENTS.md` in `~/Projects/talk_prep` with the agreed draft
- [ ] Create `checklists/` folder in the repo
- [ ] Add `checklists/day_2_checklist.md` to the repo
- [ ] Commit both files:
      `git add AGENTS.md checklists/day_2_checklist.md && git commit -m "Add AGENTS.md and Day 2 checklist"`
- [ ] Open Aider: `aider --model ollama/qwen2.5-coder:14b`
- [ ] Add AGENTS.md to context: `/add AGENTS.md`
- [ ] Give Aider this vague task:
      *"Add a placeholder module for processing braindumps"*
- [ ] Observe: Did it stay on Ollama? Invent any deps? Run `mix compile` before declaring done?
- [ ] Note what surprised you in `sprint_log.md` under Day 2

---

## Stretch goal

- [ ] Run the same task *without* AGENTS.md in context
- [ ] Compare the two outputs — what changed?

---

*The contrast between with-context and without-context is how the Level 3
instinct gets built.*
