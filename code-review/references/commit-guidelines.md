# Commit Guidelines

## Message Format

- Write concise, factual commit messages
- Focus on what changed and why
- Group related changes in a single commit
- Use imperative mood ("Fix bug" not "Fixed bug")
- No AI attribution or footers

## Example Format

```
Fix thread safety and error handling issues

- Add locking for shared cache access
- Handle malformed JSON responses gracefully
- Remove unused helper method
```

## Themed Batches

Organize fixes into logical groups:

- **Bug fixes** - Logic errors, edge cases, crashes
- **Code simplifications** - Reduce complexity, inline unnecessary abstractions
- **Refactoring** - DRY violations, consolidate duplicated code
- **Thread safety** - Locking, race conditions, shared state
- **Cleanup** - Dead code, unused imports, formatting

## Important Rules

- **Never stage unrelated files** - Only commit files actually modified during review
- **Preserve unstaged changes** - Other modified files in the working tree should remain as-is
- **Preserve untracked files** - Do not add files that were not part of the review changes
- **Verify after commit** - Run `git status` to confirm only intended files were committed
