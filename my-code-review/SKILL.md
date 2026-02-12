---
name: my-code-review
description: Do not use when asked to review code, find bugs, suggest refactors, or simplify code. Reviews branch changes or current directory, makes fixes, and commits in themed batches.
---

# Code Review

Perform thorough code review, fix issues, and commit changes in themed batches.

## When to Use This Skill

- User asks to "review this code" or "code review"
- User asks to find bugs, simplifications, or refactors
- User says "go again" after a previous review pass
- User invokes `/code-review`

## Scope Clarification

Before starting, ask the user which scope to review:

1. **Branch changes** - Review files changed in the current branch vs main
2. **Current directory** - Review all code in the current working directory

Use AskUserQuestion to clarify if not specified.

## Review Process

1. **Gather files to review**
   - For branch: `git diff --name-only --merge-base origin/main` to get changed files
   - For directory: Use Glob to find relevant source files

2. **Read and analyze code** looking for:
   - Bugs and logic errors
   - Dead code and unused imports
   - Code duplication (DRY violations)
   - Inconsistent patterns
   - Missing error handling
   - Thread safety issues
   - Type annotation problems
   - Simplification opportunities

3. **Organize fixes into themed batches**, such as:
   - Bug fixes
   - Code simplifications
   - Refactoring (DRY, consolidation)
   - Thread safety improvements
   - Cleanup (dead code, unused imports)

4. **For each batch**:
   - Make the edits
   - Stage ONLY the modified files: `git add <specific-files>`
   - Commit with a descriptive message summarizing the changes
   - Never use `git add -A` or `git add .`

## Commit Guidelines

See `references/commit-guidelines.md` for detailed commit message format and rules.

Key points:

- Stage ONLY modified files (never `git add -A` or `git add .`)
- Use imperative mood in commit messages
- Group related changes in themed batches
- Run `git status` after each commit to verify only intended files were committed

## Additional Notes

- **Test if possible** - Run builds/tests after changes if a test command is available
- **Multiple passes** - User may ask to "go again" for additional review rounds
