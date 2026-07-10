---
name: badge-in
description: Load recent session context and corrections at the start of a work session
---

# Session Start

Load cross-session memory to establish continuity from previous work sessions.

## Your Task

$ARGUMENTS

## Instructions

### 1. Load Corrections

Read `~/.claude/handoff/corrections.md` in full. Apply these corrections for the rest of the conversation. Do not summarize them back to the user unless asked — just internalize them.

### 2. Load the Handoff document

Ask the user for the name of the handoff document they wish to resume from. Handoff documents are markdown files in `~/.claude/handoff/`

Once you have found the appropriate handoff document, read it so you get the full context of what happened in the previous session, and where you need to continue from.

### 3. Ready Check

End with a brief confirmation that context is loaded and you're ready to work. Give a _very_ brief (one to two sentences) description of what we are working on what the next steps are.
