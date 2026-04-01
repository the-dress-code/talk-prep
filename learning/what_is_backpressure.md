# What is backpressure?

Backpressure is when a system pushes back on the thing using it — giving feedback that forces the user to slow down, adjust, or fix something before continuing.

In agentic engineering, backpressure means the harness gives the agent a signal it has to act on. Tests fail, the linter complains, the health check says Ollama is down — and the agent can't just ignore it and move on. It has to respond.

The opposite of backpressure is an agent that explores freely and decides for itself what to check and when. That agent might read source files, spot a bug visually, and then run verify.sh just to confirm. verify.sh wasn't driving — it was a receipt. That's not backpressure.

## Why it matters

Backpressure is what makes a harness reliable. Without it, the agent takes the shortest path to looking done — which may not be the path you designed. With it, the agent has to go through your quality gate, not around it.

## How we use it

verify.sh is our backpressure mechanism. The feedback loop protocol in AGENTS.md enforces it: run verify.sh first, read the output, fix only what it tells you. The agent can't skip to file reading — the protocol is a constraint, not a suggestion.

## From the Bassim article

"Automated feedback mechanisms (type systems, tests, linters, pre-commit hooks) that let agents detect and self-correct without human oversight." That's backpressure.
