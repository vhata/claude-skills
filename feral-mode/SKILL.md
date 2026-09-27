---
name: feral-mode
description: Use when the user grants broad autonomy with phrases like "go wild", "go apeshit", "cocaine-fueled wild", "hack away at it", "do as much as you can", "I'm going to bed", "carry on autonomously", "go feral", "rampage", or "unleash" — signals the user wants extended unattended work with an audit trail rather than in-loop approvals.
---

# Feral Mode

## Overview

Feral mode is sustained autonomous work with two guarantees: **only two-way doors get walked through, and every load-bearing decision is logged** so the user can review, accept, or revert when they're sharp again.

**Core principle:** *Reversibility, not permission.* Don't ask for approval on routine implementation calls — take only reversible actions and write the load-bearing ones down. Stop only when the next required step is irreversible or requires a real judgment call.

This skill is the formalised, triggered version of the "Autonomous work" rules in the user's global CLAUDE.md. Those rules are the source of truth; this skill operationalises them.

## When to Use

Activate on any of these (or clear equivalents):

- "go wild" / "go apeshit" / "cocaine-fueled wild"
- "hack away at it" / "do as much as you can"
- "I'm going to bed" / "carry on autonomously"
- "unleash" / "rampage" / "go feral"

Do **not** activate from generic phrases like "keep going", "continue", or "next step" — those don't grant unattended autonomy.

**On activation, announce once:** *"Feral mode active — working autonomously, audit trail at `AUDIT.md`, will stop at any one-way door."*

## The Discipline

### 1. Two-Way Doors Only

Freely allowed (reversible — and *encouraged*; commits on a feature branch are how the user reviews your work alongside `AUDIT.md`):
- Create branches, make local commits
- Edit or delete files that are tracked in git, and create new files. A file you created this session can be edited or deleted freely until its final form is committed; commit it once it has settled
- Run tests, type checks, builds, formatters, linters
- Spawn worktrees, dispatch agents
- Add or remove dependencies on a feature branch
- Refactor, restructure, scaffold

Only git makes a working-tree change reversible. An untracked file you didn't create, or uncommitted changes to a tracked file, can't be recovered through git, so leave them alone; if the work needs them changed, log it as blocked.

A local commit is a two-way door. `git push` is the one-way door. Don't conflate them — leaving a working tree full of unstaged changes for the user to sort through is *worse* than committing, not safer.

**Never without an explicit user OK** (one-way doors):
- `git push` to any remote (including new branches), `git push --force`
- Merging into `main` or any shared branch
- Tags, releases, deployments
- `rm -rf` outside the working tree; deleting branches with unmerged work
- Database migrations against shared/staging/production state
- Sending messages on Slack/Discord/email/etc., posting to external services
- Closing/commenting on PRs or issues
- Modifying shared CI/CD config
- Anything affecting third-party state (cloud resources, DNS, secrets, billing)

When the next step is a one-way door, **stop**. Log to `AUDIT.md` with `Status: blocked`, summarise what's needed, and wait. Do not manufacture permission from earlier context.

### 2. Audit Trail

Every load-bearing decision goes into `AUDIT.md` at the repo root. A decision is load-bearing if it:

- Changes a public interface, schema, or data shape
- Picks between materially different approaches (not just style)
- Removes or replaces existing functionality
- Introduces a new dependency, tool, or pattern
- Would be hard to find later via `git log` alone

Routine calls (variable names, internal helpers, obvious bug fixes) don't need entries. The audit is for things the user would reasonably want to review.

**Setup before first audit write in a session:**
```bash
grep -qxF 'AUDIT.md' .gitignore 2>/dev/null || { [ -f .gitignore ] || touch .gitignore; echo 'AUDIT.md' >> .gitignore; }
[ -f AUDIT.md ] || printf '# Audit Log\n\nFeral-mode decisions, append-only.\n\n' > AUDIT.md
```

**Entry format** (append, never edit prior entries):
```markdown
## YYYY-MM-DD HH:MM — Short title
**Chose:** what was decided
**Why:** the reasoning, including alternatives considered
**Undo by:** specific command, file, or branch to revert
**Status:** done | blocked | needs review
```

Use absolute timestamps (not "today" or "just now"). The "Undo by" line must be precise enough that a user reading it cold can revert in one step (`git revert <sha>`, `rm path/to/file`, `git branch -D feral/<name>`, etc.).

### 3. Worktree Fan-Out

When work splits into 2+ independent threads with no shared state, dispatch parallel agents in worktrees rather than working sequentially.

- Use `superpowers:using-git-worktrees` for worktree creation.
- Use `superpowers:dispatching-parallel-agents` for agent dispatch.

Branch naming: `feral/<short-topic>`. Each worktree gets one task; do not fan out across work that touches the same files or shares state — that creates merge hell.

Log a single audit entry summarising the fan-out (what threads, why parallel was correct), not one per worktree.

### 4. Page Off When Blocked

Stop and log `Status: blocked` when:

- The next required step is a one-way door (§1)
- A real judgment call comes up that the user would normally make (architecture choice, naming for a public API, scope decision)
- A fix isn't working and the next attempts would change semantics in non-obvious ways
- Tests/lint/typecheck failures persist that you cannot resolve confidently

Do not invent permission. Do not rationalise that prior context "implies" approval. Stop, log, wait.

### 5. End-of-Run Report

When wrapping (work complete, blocked, or stopping for the night), produce a terse summary:

- **Branches/worktrees created** — list with current state
- **Decisions logged** — count, with pointer to `AUDIT.md`
- **Blockers** — anything `Status: blocked` needing user input
- **Suggested next steps** — what to review first

The audit doc has the detail; this summary is the index.

## Quick Reference

| Action | Allowed? |
|---|---|
| Local commit on a feature branch | ✅ |
| Create branch, push to remote | ❌ — needs permission |
| Add npm/pip dep on a branch | ✅ |
| Modify shared CI config | ❌ — needs permission |
| Edit or `rm` a tracked file with no uncommitted changes | ✅ (recoverable via git) |
| Edit or `rm` a file created this session | ✅ (commit its final form) |
| Edit or `rm` an untracked file you didn't create, or discard uncommitted changes | ❌ — not recoverable |
| `git push --force` (any branch) | ❌ — never without explicit ask |
| Spawn worktree + agent | ✅ |
| DB migration on local SQLite | ✅ |
| DB migration on staging/prod | ❌ — needs permission |
| Comment/close on a PR or issue | ❌ — needs permission |
| Send message to Slack/Discord/email | ❌ — needs permission |
| Install/uninstall global tools | ❌ — needs permission |

## Red Flags — Stop and Log

If any of these thoughts surface, **stop**:

| Thought | Reality |
|---|---|
| "The user implied this was OK earlier" | They granted autonomy, not permission for any specific one-way door. Log and wait. |
| "It's just a small push" | Pushing is a one-way door regardless of size. |
| "I can always revert it" | If revert is non-trivial — affects others, requires coordination — it's a one-way door. |
| "This is obviously what they'd want" | Obviously ≠ explicitly. Log it as blocked. |
| "Logging this would clutter `AUDIT.md`" | The audit exists for exactly this. Log it. |
| "The audit entry can wait until the end" | Audits are immediate. Write before the next action; you will forget the *why*. |
| "I'll just amend the entry later" | Append-only. Never edit prior entries. |
| "Going to bed means they trust me to push" | Going to bed is *more* reason to be cautious — they can't course-correct in real time. |

## Common Mistakes

- **Logging trivia.** Don't audit variable renames or comment fixes. Reserve for decisions worth review.
- **Skipping "Undo by" because it's obvious.** It is never obvious in two weeks. Always specify.
- **Leaving work uncommitted at end-of-run.** A working tree of unstaged changes is harder to review than a sequence of themed commits on a feature branch. Commit early, commit often, push never — local commits are the reversible review surface, not the dangerous one. The asymmetry is: pushing to a remote is one-way, committing to a local branch is two-way (`git reset --soft HEAD~N` or `git revert <sha>` undoes it without losing the working tree).
- **Trying to clear all blockers before reporting.** If blocked, log and stop; don't dig.

## Cross-References

- `superpowers:using-git-worktrees` — required for fan-out
- `superpowers:dispatching-parallel-agents` — required for fan-out
- User's global CLAUDE.md "Autonomous work" section — canonical source of these rules

## End State

When the user returns, they should be able to:

1. Read `AUDIT.md` top-to-bottom and understand every load-bearing call
2. Revert any single decision in one step via its "Undo by" line
3. Pick up any `Status: blocked` item and unblock it
4. Trust that nothing irreversible happened without their explicit OK
