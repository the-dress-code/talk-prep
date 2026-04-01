Here's your Day 12 checklist:

---

**Day 12 — Upgrade verify.sh into a feedback loop** *Goal: agent runs verify.sh, parses output, decides what to fix, fixes it, and re-runs — no human in the loop*

*  Read current verify.sh and note what it currently outputs
*  Decide what "parseable output" means — what format lets an agent identify which check failed and why
*  Upgrade verify.sh to emit structured, agent-readable output (e.g. labeled sections, exit codes per phase)
*  Write a small intentional failure (break a test or introduce a compile error) and run verify.sh — confirm the output tells the agent exactly what broke
*  Restore the failure, then let the agent run the full loop: verify.sh → read output → identify fix → apply fix → re-run verify.sh → confirm green
*  Evaluate: did the agent need any guidance, or did it actually self-correct from the output alone?
*  Re-evaluation checkpoint — answer these four questions honestly before moving to Day 13:
   * What Level 4/5 gaps surfaced since last checkpoint? Were they fixed?
   * Is the harness actually catching problems, or is Wendy still catching them manually?
   * Is the plan still serving the goal (solid Level 6) or has it drifted?
   * Does anything need to change for the next 3-4 days?
*  Update progress.md and sprint_log.md with Day 12 state

**Stretch goal if time allows:**

*  Document the feedback loop protocol in AGENTS.md — what the agent should do when verify.sh exits non-zero — so Day 13 can use it autonomously without coaching

---

That's it. The goal isn't a fancier script — it's a closed loop. By end of day the agent should be able to find and fix a failure from verify.sh output alone, with no human explaining what went wrong.

---

*Generated: 2026-03-31*
