# What is a harness?

A harness is everything you put in place *before* an agent writes code, so the agent can verify its own work without you checking every line.

In plain terms: instead of saying "build me a Socratic questioner" and hoping it's right, you first define exactly what "right" looks like. Then the agent builds against that definition and checks itself.

## Our harness for the Socratic questioner has two parts

**1. The feature contract** (in AGENTS.md)

A precise written spec: what commands exist, what goes in, what comes out, how the user exits, where files get saved, what "done" means. Without this, the agent guesses at all of those things.

**2. The test stubs** (in test/socratic_questioner_test.exs)

9 failing tests, one per behavior we care about. When an agent writes the implementation on Day 13, it runs `mix test`, sees which tests fail, fixes the code, runs again. It can do this loop without you watching.

## Why build the harness before the code?

Because if you write tests *after* the code, you unconsciously write tests that match what you built — not what you actually wanted. Writing them first forces you to think clearly about what you want before any code exists.

## How to explain it to someone

"Before the agent writes anything, I define exactly what the finished feature looks like — what it takes in, what it puts out, and what counts as done. I turn that definition into failing tests. Then the agent writes code until the tests pass. I don't have to review every line — the tests do that for me."
