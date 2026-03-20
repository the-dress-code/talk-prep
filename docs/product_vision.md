# talk_prep — Product Vision

## What it is
A private, local CLI tool that helps organize unstructured writing into
structured talk outlines. Runs entirely locally (Ollama + Qwen) for privacy.

## Core constraint
**Never invent, only organize.** Every output must come from the user's own
words and ideas. The tool extracts, questions, and structures — it does not
generate content unless explicitly asked.

## Features (priority order)

### Organize mode (core constraint: never invent, only organize)

#### 1. Braindump ingestion (exists — needs verification)
Dump text in (all at once or in pieces over time). Extract themes, claims,
and supporting evidence from the user's writing without adding anything.

#### 2. Socratic questioner
When a claim lacks supporting evidence, ask the user leading questions to
draw it out. Store answers for later use. The user values the Socratic
method — questions over answers.

#### 3. Abstract → skeleton
Ingest a talk abstract plus constraints (number of acts, duration, audience)
and produce a starting structure with talking points derived from the abstract.

#### 4. Redundancy mapper
Given a structured outline (or raw text organized by sections/acts), identify
overlapping ideas across sections and suggest where each one belongs most
naturally. Can suggest fixes, not just flag problems.

#### 5. Modular idea store
Ideas land as discrete, tagged pieces that can be grouped, reorganized, and
eventually mapped to a visual structure (e.g., Excalidraw board with acts
as branches, talking points, and supporting items).

### Improve mode (AI-powered, allowed to generate/suggest)
A separate, opt-in mode where the LLM *is* allowed to suggest improvements —
rewording, strengthening arguments, filling gaps, etc. Must be explicitly
invoked; never runs by default. What "improve" means will be defined as
the tool evolves.

## First real use case
Dutch Clojure Days — May 8, 2026, Amsterdam
"Clojure as Your First Language: Shaping a Functional Mindset"
45 minutes, beginner-friendly, 3-act structure.
Rehearsal target: April 5, 2026.

## Input formats to support
- Plain text (.txt) braindumps
- Markdown (.md) notes and outlines
- Marp slides (slides.md with inline comments)
- Talk abstracts (plain text)
