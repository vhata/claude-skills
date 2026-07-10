---
name: handoff
description: Write a session handoff note before ending a substantive work session
---

Write a handoff note to the appropriate session log so the next session can pick up where this one left off.

## Your Task

$ARGUMENTS

## Instructions

### 1. Assess the Session

Review what happened in this conversation. Only write a handoff note if the session involved **substantive work** — decisions made, problems investigated, documents created, or significant context built up. Skip if the session was just a quick question or trivial task.

If the session wasn't substantive enough for a handoff note, say so and end.

**Admission quality check:** For each piece of information you'd include in the handoff note, ask:

- **Novel?** Does this extend or contradict something already in the system (skills, commands, stable-facts)? If it's already baked in, don't re-store it.
- **Actionable?** Can a future session use this? Debugging dead-ends and one-off lookups usually aren't worth recording.
- **Durable?** Will this matter in 2 weeks? Open threads and decisions yes; transient investigation details usually no.

Use judgment — these are quality filters, not hard gates. The goal is to keep the session log high-signal.

### 2. Write the Entry

Write a markdown file with an appropriate name for this session. The files will live in ~/.claude/handoff/
Confirm the name with the user, and allow them to modify it if they want to.

Use this exact format:

```markdown
## YYYY-MM-DD — [Brief topic description]

**What happened:** [1-3 sentences summarizing what was done. Be specific — mention file paths, ticket IDs, project names.]

**Decisions:** [Any decisions made during the session. Reference where they were documented if applicable.]

**Learned:** [Anything discovered that should persist — debugging insights, preferences expressed, corrections needed, approach that worked/didn't work. If nothing notable, omit this field.]

**Open threads:** [What's unfinished or needs follow-up. This is essentially a "TODO".]
```

### 3. Promote Learnings to Infrastructure

This is the most important step. Session logs capture _what happened_, but institutional knowledge only persists if it gets baked into the files the agent actually loads. Review the session and check whether any learnings, workflow improvements, or behavioral fixes should be promoted to infrastructure files.

**Promotion targets (check each one):**

| Target          | When to promote                                                                                   | File(s)                            |
| --------------- | ------------------------------------------------------------------------------------------------- | ---------------------------------- |
| **Skill**       | Domain knowledge was gained, a decision tree needs a new branch, or a lookup table needs updating | `~/.claude/skills/*/SKILL.md`      |
| **Agent**       | An agent needs new instructions, a better prompt, or a new agent would be useful                  | `~/.claude/agents/*.md`            |
| **CLAUDE.md**   | A system-level convention changed, a new trigger was identified, or structural changes are needed | `CLAUDE.md`                        |
| **Decisions**   | A cross-cutting decision was made that should be recorded for future reference                    | `~/.claude/handoff/decisions.md`   |
| **Corrections** | A behavioral fix has no better home yet — use as a staging area, not a permanent destination      | `~/.claude/handoff/corrections.md` |

**How to promote:**

1. For each learning, identify the best target. Prefer infrastructure files (commands, skills, agents, AGENTS.md) over corrections. Corrections is the staging area for things that don't fit anywhere else _yet_.
2. Read the target file first to understand its current state.
3. Apply the edit directly — no pre-approval step.
4. If a learning is being promoted from `corrections.md` into an infrastructure file, **remove it from corrections** — it's been baked in and no longer needs to be in the staging area.

**Judgment gate — ask before writing when:**

- The change touches a **skill, command, agent, or AGENTS.md** AND you're uncertain whether it belongs there (these files load into every future session, so a bad edit propagates). For clear-fit edits to those files — a new case in a lookup table, an obvious missing step in a command — apply directly.
- You're tempted to add a correction that might be general domain knowledge rather than an agent-specific behavioral fix.
- A change would restructure a file rather than amend it.

For stable-facts, session logs, project CONTEXTs, decisions.md, and corrections.md: always apply directly. These are low-blast-radius and easily reverted.

**If no infrastructure updates are needed**, say so explicitly: "No infrastructure updates needed from this session." Don't silently skip this step.

### 4. Confirm

Report in this order so a bad change is easy to catch:

- **High-blast edits (flag prominently if present):** any edits to `.claude/skills/`, `.claude/agents/`, or `CLAUDE.md`. These load into every future session — if the user disagrees, they'll want to revert immediately.
- **Corrections:** entries added, entries retired (baked in elsewhere).
- **Project CONTEXT / decisions.md:** what was changed.

Format the report so the user can scan it in <10 seconds and spot anything that looks wrong. Revert path: `git diff` + `git checkout -- <file>` for any single change.
