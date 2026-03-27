# Agentic Engineering Sprint Log

## How to use this file
Read this file, progress.md, and AGENTS.md at the start of every session.
These three files together give a complete picture: sprint_log has the plan
and history, progress.md has current state and what's next, AGENTS.md has
constraints and what the agent needs to know to write code.

---

## Session conventions

### Real-time coaching (added Day 10)
**IMPORTANT — do this during every session, not just when asked:**

1. When Wendy does something that maps to a level, say so immediately.
   Format: "**Level N — [concept name]:** [what just happened and why it matters]."
   Example: "**Level 4 — compounding:** You just updated AGENTS.md so the next session won't hit the same problem."

2. When Wendy does something that's an anti-pattern, flag it immediately.
   Format: "**Anti-pattern — [name]:** [what happened and what should happen instead]."
   Example: "**Anti-pattern — verbal context:** You just told me something the next session won't know. Should this go in AGENTS.md or progress.md?"

3. When the agent can't do something or misses context from a prior session, flag it as a level gap.
   Format: "**Level N gap:** [what's missing and how to fix it]."
   Example: "**Level 4 gap:** I didn't know about X from last session. That should be in AGENTS.md so future sessions pick it up."

4. Every sprint log entry MUST include a "Levels practiced" section at the end.

5. After completing a feature rep, explicitly compare it to the previous rep: what went faster, what the harness caught that it didn't before, what still needs work.

6. Do NOT just agree when Wendy assesses her own progress. Check it against evidence.
   If she says "the harness is working" but she manually fixed things the harness should
   have caught, say so. If she says "I think I'm Level 6" but the walk-away test produced
   broken code, say so. Be honest — Wendy has explicitly asked for this.

### Daily checklist generation
- At the start of each day's session, generate a printable day checklist
  in the same format as the Day 1 checklist (goal, bullet steps, stretch goal).
- Follow the style of the Day 1 checklist exactly: opening line "Here's your Day N checklist:",
  horizontal rule, bold title with goal, plain `*` bullet steps (no bold, no sub-sections),
  stretch goal block, horizontal rule, one closing sentence, horizontal rule, timestamp.
- Save the checklist as a markdown file in `checklists/day_N_checklist.md` and
  commit it to the repo.
- Also display the checklist in the chat message so it can be copied directly
  into Google Docs. Add a timestamp at the bottom of the md file (below a
  horizontal rule) in the format: *Generated: YYYY-MM-DD* — keep it out of
  the main checklist body.

- Commit message format: `type: Day N — short description` as the title, optional body with detail.
  Types: `feat` (new code/behavior), `docs` (docs/logs only), `test` (tests only), `fix` (bug fix).
  Example: `feat: Day 9 — add verify.sh, install credo, lenient default with --strict flag`

- At the end of each day's session, after presenting the updated sprint log, ask the
  human to confirm they are happy with it before proceeding. Once confirmed, generate
  a Slack check-in message using the day's log entry (Completed, Lessons learned,
  Left off at) as the source. Format: first line is "Day N: Agentic Engineering
  Learning Sprint" followed by a second line with the day's goal as a title. Then
  concise bullet points — what got done, what was learned. No markdown, no asterisks,
  no formatting symbols. Use "Next:" instead of "Tomorrow:" for the closing item.
  Keep it tight. Manager knows about the sprint — no need to over-explain.

---

## Sprint plan
*Living document — restructured on Day 10. The "leveled up when"
criteria matter more than the day count.*

### Sprint context
- Wendy has 5-6 hours per day for this sprint
- Talk is already in bullet-point outline format — braindump processor not needed for talk prep
- Socratic questioner is the highest-value feature for real talk prep right now

### Phase 1 — Environment & Level 3 (Days 1-5) ✅

**Level 3 leveled up when:** you can predict in advance whether a prompt will
confuse the agent, and you know how to fix it before running it. ✅

### Phase 2 — Level 4 & 5 (Days 6-12)

**Level 4 leveled up when:** you start a session and the agent already "knows"
things you taught it last week, because you codified them properly.

**Level 5 leveled up when:** your agent can do something it literally could not
do before — access a real system, run a real check.

### Phase 3 — Level 6 via feature reps (Days 13-19+)

**Level 6 leveled up when:** you give the agent a task, walk away, and come
back to find it either finished and verified — or clearly stuck with a specific
question. Not silently broken. Not falsely done. And rep 2 goes noticeably
faster than rep 1.

### Detailed day-by-day plan

**Days 11-12 (Mar 27-28): Upgrade harness + Level 4 validation**

Day 11: Test compounding (Level 4 validation)
- Open a fresh CLI session — do NOT paste context, just point it at sprint_log
- Give it a real task (not trivial)
- Document: what did the agent already "know"? What did it miss?
- Fix the gaps in AGENTS.md / progress.md so the next session is better
- This directly addresses the Level 4 question mark

Day 12: Design harness for Socratic questioner
- Write the feature contract in AGENTS.md (input/output shape, constraints, done criteria)
- Write test stubs that define expected behavior before any code is written
- Upgrade verify.sh into a real feedback loop: agent runs it, parses output, decides what to fix, fixes it, re-runs — no human needed
- By end of day: harness is ready for the agent to build against on Day 13
- **Re-evaluation checkpoint.** Answer these honestly before moving on:
  - What Level 4/5 gaps surfaced since last checkpoint? Were they fixed?
  - Is the harness actually catching problems, or is Wendy still catching them manually?
  - Is the plan still serving the goal (solid Level 6) or has it drifted?
  - Does anything need to change for the next 3-4 days?

**Days 13-16 (Mar 29 - Apr 1): Socratic questioner — first full Level 6 rep**
- Day 13: Agent builds inside the harness. Walk-away test — give the task, step away for real, come back and evaluate
- Day 14: Evaluate what harness caught and what it missed. Tighten constraints. Agent fixes using improved harness
- Day 15: Agent-Y adversarial review — separate session critiques the feature. Assess: would you trust this without reviewing every line?
- Day 16: **Re-evaluation checkpoint.** Answer these honestly before moving on:
  - What Level 4/5 gaps surfaced since last checkpoint? Were they fixed?
  - Is the harness actually catching problems, or is Wendy still catching them manually?
  - Did rep 1 produce something you'd trust without reviewing every line? If not, why?
  - Is the plan still serving the goal (solid Level 6) or has it drifted?
  - Does anything need to change for rep 2?

**Days 17-19 (Apr 2-4): Redundancy mapper or modular idea store — second Level 6 rep**
- Same rep cycle: design harness → agent builds → walk away → evaluate → tighten → adversarial review
- Should go faster because harness is better. If it doesn't, that reveals what was missed in rep 1

**April 5: Use Socratic questioner on real talk content for April 7 dry run**

**Days 20+ (Apr 6 onward, if time): Third rep, polish, or re-evaluation**
- Third feature, improve mode, or harness improvements based on what broke in reps 1 and 2
- **Re-evaluation checkpoint.** Answer these honestly:
  - Did rep 2 go noticeably faster than rep 1? If not, what's still missing from the harness?
  - Can Wendy articulate what makes a harness good or bad? Ask her.
  - Is the Socratic questioner actually useful for the April 7 dry run?
  - What would Wendy do differently if starting a new project with harness engineering from scratch?

### Key deadlines
- Mar 31: First dry run (rough — bullet points on slides, 10-20 per act of 3 acts)
- Apr 5: Socratic questioner ready for real use
- Apr 7: Second dry run
- Apr 13: Third dry run
- Apr 19: Leave for international trip (morning)
- May 8: Dutch Clojure Days talk, Amsterdam

---

## Daily Log

*Days 1-7 archived to docs/daily_log_days_1_7_archive.md — lessons are captured in current docs.*

---

### Day 8 ✅
**Goal:** Claude Code takes over — phase out Aider, wire up something real

**Completed:**
- Decided to phase out Aider + Qwen. Rationale: Aider taught context engineering
  (L3) and compounding (L4), but Qwen's limitations (inventing content,
  needs_points broken, non-deterministic) make it a poor fit for L5+ work. Claude
  Code (Pro plan) handles both coding and orchestration from here. Multi-agent
  returns at Day 15 — automated and adversarial, not manual.
- Updated AGENTS.md to reflect Claude Code as sole agent
- MCP deferred — Claude Code's built-in tools (bash, file I/O, mix run -e) already
  close the feedback loop for this project. No gap to fill right now. Revisit when
  a real capability gap appears (see docs/mcp_notes.md).
- Built `mix braindump` CLI entry point — first real coding task done by Claude Code.
  Processes a file and prints themes, topics, points, and details in readable format.
- Removed placeholder process_file/1 from FileIngestor — clean compile, no warnings
- Updated AGENTS.md, progress.md, and sprint log with Day 8 state

**Key decisions:**
- Aider + Qwen phased out on Day 8 as the sprint plan originally called for
- MCP deferred — Claude Code can already run the processor via `mix run -e`,
  run tests, and edit code. No capability gap to fill right now.

**Lessons learned:**
- Multi-agent management *is* part of agentic engineering, but the Level 6 version
  is automated orchestration (agent dispatches to agent), not manual terminal
  switching. That's Day 15, not Day 8.
- Don't bolt on tools to check a box — wait for a real friction point
- Claude Code worktrees caused confusion about where files landed — caught it
  mid-session, switched to writing directly to main repo

**Left off at:** CLI working (`mix braindump`). All tests passing, clean compile.
verify.sh is next (Day 9). Product gate getting closer — tool is now usable from
the terminal.

---

### Day 9 ✅
**Goal:** First step toward harness engineering — a quality gate the agent can run and interpret, not just a human convenience script

**Completed:**
- Added credo to mix.exs (dev/test dep), ran `mix deps.get`
- Built verify.sh: runs `mix compile`, `mix test`, `mix credo` in sequence
  - Default (lenient): credo issues shown but non-blocking
  - `--strict` flag: fails on any credo issue (runs 69 checks vs 57 in default)
- Made verify.sh executable, confirmed it runs cleanly
- Agent-Y verification: opened a fresh Claude Code session, ran verify.sh cold —
  reported correctly with no prior context (compile clean, 3 tests passing,
  3 non-blocking credo issues)
- Tested `--strict` flag: exits non-zero as expected on existing credo issues
- Added verify.sh to AGENTS.md CLI section for later discovery

**Key decisions:**
- Lenient default, `--strict` for hard gate — don't block active development on
  pre-existing issues, but give a strict mode for CI or handoff
- Agent-X (coding) runs `mix compile` + `mix test`; Agent-Y (verifier) runs `./verify.sh`
  — the distinction maps directly to the Bassim Eledath framework

**Lessons learned:**
- Credo is a static analysis tool for Elixir: checks readability, style, and
  refactoring opportunities. Alternatives: dialyxir (type checking), sobelow (security).
  We chose credo because it's fast and gives immediate, actionable feedback.
- `--strict` enables additional checks beyond the default set — it's not just
  "fail louder", it's "check more"
- Agent-Y verification worked in practice: a cold session ran the script and
  reported accurately with no coaching

**Left off at:** verify.sh committed and verified. All tests passing, clean compile.
Ready for Day 10.

---

### Day 10 ✅
**Goal:** Re-evaluate sprint plan — is it actually going to produce solid Level 6?

**Completed:**
- Re-read all three source articles (Bassim Levels of Agentic Engineering, OpenAI Harness Engineering, Anthropic Effective Harnesses) and all project docs (product_vision.md, AGENTS.md, progress.md)
- Audited current plan against Level 6 criteria. Found critical gaps:
  - Only 1 new feature planned across 7 remaining days — not enough reps to build muscle memory
  - Most remaining days were checkpoints and observation, not building
  - Project too small (one module, one CLI command) to stress-test harness engineering
  - verify.sh is a gate (pass/fail), not a feedback loop — a real feedback loop means the agent runs verify.sh, parses the output, decides what to fix, fixes it, and re-runs verify.sh without human intervention
  - Walk-away test (Day 13) had nothing complex enough to fail in interesting ways
- Assessed readiness for each level:
  - Level 3: ✅ solid
  - Level 4: ⚠️ partial — compounding mechanism exists (sprint_log, progress.md, AGENTS.md) but never tested: does a fresh session actually pick up prior context without hand-holding?
  - Level 5: ⚠️ partial — verify.sh is the only new capability. One capability isn't a pattern.
  - Decision: don't gate on 4-5 completion. They'll surface naturally during Level 6 feature builds. Address in the moment.
- Restructured Days 11-19+ around building 2-3 real features as Level 6 rep cycles
- Settled tooling after extensive discussion (see Tool setup section below)
- Agreed on real-time level callouts: Claude flags Level 3-6 behaviors and anti-patterns during builds, naming the specific level and article concept, to build vocabulary alongside skills
- Agreed on anti-pattern callouts: Claude flags when Wendy manually fixes something the harness should catch, gives context verbally that should be in the repo, etc.
- Added recurring daily check: "Did I hit a Level 4 or Level 5 gap today? What was it? How did I fix it?"
- End-of-day sprint log entries will include a "Levels practiced" section going forward
- Between reps: explicitly compare rep 1 to rep 2 — did harness improve? Did you catch things faster? That's proof of leveling up.

**Key decisions:**
- Target confirmed: solid Level 6 — not "can describe it" but "can do it, knows when it's working vs. broken"
- Each feature is a full Level 6 rep cycle:
  1. **Design harness** — write feature contract in AGENTS.md (input/output shape, constraints, done criteria), write test stubs that define expected behavior, update verify.sh if needed
  2. **Agent builds** — agent writes the code inside the harness constraints, runs verify.sh, interprets failures, self-corrects
  3. **Walk away** — give the agent the task, leave for real, come back and evaluate
  4. **Evaluate** — what did the harness catch? What did it miss? What broke silently?
  5. **Tighten** — fix the harness gaps found in step 4 (add tests, strengthen constraints, improve verify.sh)
  6. **Adversarial review** — fresh session (Agent-Y) critiques the feature cold. Would you trust this without reviewing every line?
- Feature priority: (1) Socratic questioner — most useful for talk prep right now, (2) redundancy mapper, (3) modular idea store (tied for 2nd)
- Rep 2 should go noticeably faster than rep 1 — if it doesn't, that reveals what was missed in rep 1

**Lessons learned:**
- The project was too small to stress-test harness engineering — can't evaluate if a harness works when nothing is complex enough to break without it
- verify.sh is a gate, not a feedback loop — Level 6 requires the agent to interpret failure and act, not just report pass/fail
- A walk-away test needs a task complex enough to fail in interesting ways
- Tool choice should optimize for the end-state workflow you'll use after the sprint, not just sprint comfort
- Wendy needs vocabulary alongside skills — being able to name what she's doing (e.g., "that's mechanical enforcement from the OpenAI article") is part of leveling up for professional conversations with colleagues

**Tool setup (settled after discussion):**

| Tool | When | Model |
|---|---|---|
| Claude Code CLI | Daily sessions — planning, building, evaluating, everything | Sonnet |
| VS Code (no Claude extension) | Open alongside CLI to read/review code and diffs | — |
| Claude Code Desktop | Only for deep strategic thinking sessions (like today) | Opus |

Why CLI as primary:
- Level 6 requires agent autonomy — agent runs bash, interprets results, self-corrects
- CLI is built for this; VS Code extension is an AI coding assistant, not an autonomous agent
- Each daily session is fresh — agent reads sprint_log to restore context
- Old CLI account access doesn't matter — sessions are stateless, context comes from sprint_log

Why not more tools:
- Context loss between tools is a real cost
- Switching mid-day breaks continuity
- Sprint log is a strong enough context bridge that Sonnet can handle planning too

**Action items for upcoming days:**
- [ ] Customize Claude Code CLI terminal font/theme for comfort (~5 min)
- [ ] Claude does real-time level callouts during all builds (Level N, concept name, article source)
- [ ] Claude flags anti-patterns in the moment (manually fixing what the harness should catch, verbal context that should be in repo, etc.)
- [ ] Every sprint log entry includes "Levels practiced" section
- [ ] Between reps: explicit comparison — what improved, what didn't

**Left off at:** Plan restructured. No code changes today. Ready for Day 11.

---

## Open questions
- needs_points flag always false — Qwen limitation (confirmed)
- ~~Is Aider + Qwen still worth it now that Claude Code is in the picture?~~
  **Resolved Day 8:** No. Phased out. See Day 8 log.

