# Agentic Engineering Framework

**When to read this file:** During re-evaluation checkpoints (every 3-4 days)
and when you need to understand why the plan is structured the way it is.
Not needed for daily coding sessions.

---

## The three source articles

1. **Bassim Eledath — "The 8 Levels of Agentic Engineering"**
   bassimeledath.com/blog/levels-of-agentic-engineering
   Levels 3–5 are the foundations. Level 6 (harness engineering + automated
   feedback loops) is the target. Skipping any level amplifies the mess instead
   of the work.

2. **OpenAI — "Harness Engineering: Leveraging Codex in an Agent-First World"**
   openai.com/index/harness-engineering
   Key insights: agents need feedback loops to self-verify; documentation lives
   in the repo not in people's heads; constraints beat instructions; AGENTS.md
   is a table of contents not an encyclopedia.

3. **Anthropic — "Effective Harnesses for Long-Running Agents"**
   anthropic.com/engineering/effective-harnesses-for-long-running-agents
   Key insights: initializer agent sets up environment; coding agent makes
   incremental progress; progress.md bridges sessions; verify before declaring
   done; test end-to-end not just unit level.

---

## Level definitions

- **Level 3 (context engineering):** control what the agent sees — quality in, quality out
- **Level 4 (compounding):** each session is smarter than the last
- **Level 5 (MCP + skills):** give the agent real capabilities beyond file edits
- **Level 6 (harness engineering):** agent verifies its own work, you step back

## Why these levels in this order

Levels 3–5 are the foundations. You can't do harness engineering (Level 6)
without good context (Level 3), compounding (Level 4), and real agent
capabilities (Level 5). Skipping any level amplifies the mess instead of
the work.

---

## Level-up criteria

**Level 3 (context engineering):** ✅ Achieved
You can predict in advance whether a prompt will confuse the agent, and you
know how to fix it before running it.

**Level 4 (compounding):** ⚠️ Partial — being validated
You start a session and the agent already "knows" things you taught it last
week, because you codified them properly.

**Level 5 (capabilities):** ⚠️ Partial — being validated
Your agent can do something it literally could not do before — access a real
system, run a real check.

**Level 6 (harness engineering):** Target
You give the agent a task, walk away, and come back to find it either finished
and verified — or clearly stuck with a specific question. Not silently broken.
Not falsely done. And rep 2 goes noticeably faster than rep 1.

---

## Principles

- **Agent-Y verifies Agent-X's work.** The agent that writes the code should
  not be the same agent that writes (or runs) the tests. Same model checking
  itself shares the same blind spots. When writing tests for new code, use a
  separate session or a different agent.

- **Never invent, only organize.** Core product constraint. All output must
  come from the user's own words and ideas. The tool extracts, questions, and
  structures — it does not generate content unless explicitly asked.

- **Repository as system of record.** (From OpenAI article.) Anything not in
  the repo doesn't exist for the agent. Context belongs in versioned files,
  not in verbal instructions or external docs.

- **Constraints beat instructions.** (From OpenAI article.) Hard rules the
  agent can't violate are more reliable than suggestions it might ignore.

- **Mechanical enforcement over documentation.** (From OpenAI article.)
  Enforce architecture through tests and linters, not prose.
