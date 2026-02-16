---
name: perfectify
description: Systematically analyze and improve a repository toward production-quality perfection. Audits architecture, testing, security, accessibility, UX, developer experience, and code quality, then executes improvements in the correct order.
---

# Perfectify

Systematically transform an existing repository into a production-quality exemplar. This skill codifies the patterns observed in a "perfect" codebase: clean architecture, comprehensive testing, security hardening, accessibility, UX polish, and developer experience.

## When to Use This Skill

- User asks to "perfectify", "make perfect", or "improve quality" of a repository
- User asks to audit and systematically improve a codebase
- User invokes `/perfectify`

## Philosophy: What Makes Software "Perfect"

Perfect software isn't about adding features — it's about doing ten things right in every dimension simultaneously. The ten pillars are:

1. **Architecture** — Clean layered separation with strict dependency rules
2. **Immutability & Purity** — Predictable state management, pure functions, minimal mutation
3. **Testing** — Tests as executable specification, not afterthought
4. **Security** — Defensive at every boundary, atomic operations, validated inputs
5. **Accessibility** — ARIA, keyboard navigation, WCAG AA contrast, screen reader support
6. **UX Polish** — Purposeful animations, dark mode, responsive, error recovery
7. **Developer Experience** — README, Makefile, CI/CD, CLAUDE.md, coverage config
8. **Git Discipline** — Focused commits, imperative messages, incremental development
9. **Error Handling** — Graceful degradation, safe defaults, no crashes on bad input
10. **Code Style** — Type hints, docstrings, consistent naming, visual organization

## Development Arc

The correct order of improvement follows a proven 5-phase arc. **Never skip phases — each enables the next.**

```
Phase 1: AUDIT        → Understand what exists
Phase 2: ARCHITECT    → Extract pure core, enforce separation
Phase 3: TEST         → Comprehensive test suite as specification
Phase 4: ENRICH       → Add features on the solid foundation
Phase 5: HARDEN       → Security, accessibility, robustness
```

---

## Phase 1: AUDIT

Read the entire codebase and produce a diagnosis. Do NOT make changes yet.

### 1.1 Architecture Audit

Identify the dependency graph. Answer these questions:
- Is there a pure logic core with NO framework/UI imports?
- Can the core logic be tested headlessly (no GUI, no network)?
- Are there circular dependencies?
- Is state mutable or immutable? Where does mutation happen?
- How many layers exist? (Ideal: pure logic → coordination → adapter → frontend)

**Red flags:**
- UI framework imports in logic files
- Business logic inside event handlers or route handlers
- Global mutable state
- God objects that mix concerns

### 1.2 Testing Audit

- How many tests exist? What's the coverage?
- Are tests organized by topic/module or randomly?
- Do tests describe behavior (specification-style) or just poke at internals?
- Is there a fast/slow test split for CI?
- Are there integration tests that exercise the full stack?

### 1.3 Security Audit

- File I/O: Are writes atomic (tempfile + rename)? Do reads handle corrupt data?
- User input: Is all external input validated? Are there XSS, injection, or path traversal risks?
- Error paths: Do error handlers leak sensitive information?
- Resource cleanup: Are file descriptors, connections, and processes properly closed?

### 1.4 Developer Experience Audit

- Is there a README with setup instructions, usage examples, and architecture overview?
- Is there a Makefile (or equivalent task runner) with common targets?
- Is there CI/CD? Does it run tests across multiple runtime versions?
- Is there a CLAUDE.md documenting conventions for AI agents?
- Is there a .gitignore covering all generated artifacts?
- Is pyproject.toml (or equivalent) properly configured with coverage thresholds?

### 1.5 Code Quality Audit

- Are there type hints on function signatures?
- Are there docstrings on public functions and classes?
- Is naming consistent? (SCREAMING_SNAKE for constants, PascalCase for classes, snake_case for functions/variables, underscore prefix for private)
- Are there visual section separators in long files?

### 1.6 Present Findings

Present a scorecard to the user:

```
Architecture:    [A/B/C/D/F] — summary
Testing:         [A/B/C/D/F] — summary
Security:        [A/B/C/D/F] — summary
Accessibility:   [A/B/C/D/F] — summary (if applicable)
UX Polish:       [A/B/C/D/F] — summary (if applicable)
Dev Experience:  [A/B/C/D/F] — summary
Error Handling:  [A/B/C/D/F] — summary
Code Style:      [A/B/C/D/F] — summary
```

Then ask the user which phases to proceed with.

---

## Phase 2: ARCHITECT

Extract a pure, testable core. This is the most important phase — it enables everything else.

### 2.1 Extract Pure Logic

Create a core module (or modules) that:
- Uses **frozen dataclasses** or equivalent immutable data structures for state
- Contains **pure functions** that take state and return new state (no mutation)
- Has **ZERO imports** from UI frameworks, web frameworks, or I/O libraries
- Exposes a complete API for all domain operations

**Pattern — Immutable State:**
```python
@dataclass(frozen=True)
class AppState:
    """All state in one immutable container. Functions return new instances."""
    items: tuple[Item, ...]  # Use tuples, not lists, for immutability

def add_item(state: AppState, item: Item) -> AppState:
    """Pure function: takes state, returns new state. Never mutates."""
    return replace(state, items=(*state.items, item))
```

**Why:** Immutable state + pure functions means no hidden side effects, trivial testing, easy undo/replay, and safe concurrency.

### 2.2 Create Coordination Layer

Extract a coordinator/controller that:
- Owns the mutable reference to the current immutable state
- Manages timers, state machines, I/O pacing
- Has NO UI framework imports
- Calls pure logic functions and updates state

### 2.3 Create Adapter Layer (if multiple frontends exist)

If the project has or will have multiple frontends (GUI, TUI, web, CLI):
- Extract shared UI state (overlays, settings, navigation) into an adapter
- Define abstract interfaces (ABC) for frontend-specific behavior (e.g., sound)
- Each frontend implements the interfaces and delegates to the adapter

### 2.4 Verify Separation

Run these checks:
- `grep -r "import pygame\|import flask\|import tkinter\|import django" core_module/` should return nothing
- The pure core should be importable and usable without installing any framework
- Draw the dependency graph and confirm it's a DAG with no upward arrows

### 2.5 Commit

One commit per extraction step. Imperative verb-first message:
```
Extract pure game logic into game_engine.py
Add GameCoordinator to manage state machine and timers
Extract shared UI state into FrontendAdapter
```

---

## Phase 3: TEST

Write tests as an executable specification of the system's behavior.

### 3.1 Test Organization

Structure tests by module and topic:
```python
class TestUserCreation:
    """Rule: Users must have a valid email and unique username."""

    def test_create_user_with_valid_data(self):
        ...
    def test_reject_user_with_invalid_email(self):
        ...
    def test_reject_duplicate_username(self):
        ...
```

**Conventions:**
- Group tests into classes by behavioral topic, with a docstring stating the rule being tested
- Name tests `test_<descriptive_action>` — they should read like specifications
- Write positive AND negative test pairs systematically
- Use helper functions (not fixtures) for test state construction — explicit is better than magic
- No mocking of internal code — only mock external I/O boundaries

### 3.2 Helper Functions

```python
def make_state(**overrides) -> AppState:
    """Create a test state with sensible defaults and optional overrides."""
    defaults = {...}
    defaults.update(overrides)
    return AppState(**defaults)
```

### 3.3 Coverage Target

- Aim for 80%+ branch coverage on the pure logic core
- Configure coverage in pyproject.toml:
  ```toml
  [tool.coverage.run]
  source = ["."]
  branch = true
  omit = ["test_*.py", "main.py"]  # Omit UI entry points

  [tool.coverage.report]
  fail_under = 80
  show_missing = true
  exclude_lines = ["pragma: no cover", "if __name__"]
  ```

### 3.4 Fast/Slow Split

Mark slow tests (integration, benchmarks, full game simulations):
```python
@pytest.mark.slow
def test_full_game_simulation():
    ...
```

Configure in pyproject.toml:
```toml
[tool.pytest.ini_options]
markers = ["slow: tests that take >10s"]
```

CI should run fast tests first, slow tests separately.

### 3.5 Commit

```
Add comprehensive test suite for core logic (N tests)
Add integration tests for coordinator
Mark slow tests for CI separation
```

---

## Phase 4: ENRICH

Add features on the solid foundation. Each feature follows the same pattern.

### 4.1 Feature Development Pattern

For each feature:
1. **Engine first** — Add pure logic to the core module + tests
2. **Coordinator next** — Wire it into the state machine + tests
3. **Frontend last** — Add UI rendering/interaction
4. **One commit per layer** with a descriptive message

### 4.2 Feature Categories to Consider

**User Experience:**
- Undo/redo (trivial with immutable state — just keep a history stack)
- Keyboard shortcuts (comprehensive, documented in help overlay)
- Dark mode (CSS custom properties or equivalent theming)
- Colorblind mode (never rely solely on color — add patterns, labels, borders)
- Sound effects (synthesized, no external assets needed)
- Animations (purposeful: confirm actions, show state changes, provide feedback)
- Autosave with resume on startup
- Persistent user settings

**Data & History:**
- Score/result history persisted to disk (JSON)
- Post-session statistics and analysis
- Turn-by-turn replay/log

**AI/Automation (if applicable):**
- Multiple strategy levels from simple to optimal
- Strategy explanations visible in UI
- Benchmark CLI for headless evaluation

### 4.3 Commit Discipline

Every commit should:
- Start with an imperative verb (Add, Fix, Update, Remove, Refactor, Extract)
- Describe a single logical change
- Be unique (no duplicate messages across the entire history)
- Include test count when adding tests: "Add GameCoordinator with 69 tests"

---

## Phase 5: HARDEN

The final pass makes everything production-quality. This is the difference between "works" and "perfect."

### 5.1 Security Hardening

**Atomic File Writes:**
```python
import os, tempfile

def atomic_write(path: Path, data: str) -> None:
    """Write data to file atomically — no corruption on crash."""
    fd, tmp = tempfile.mkstemp(dir=path.parent, suffix=".tmp")
    closed = False
    try:
        os.write(fd, data.encode())
        os.close(fd)
        closed = True
        os.replace(tmp, path)  # Atomic rename
    except BaseException:
        if not closed:
            os.close(fd)
        try:
            os.unlink(tmp)
        except OSError:
            pass
        raise
```

Apply to ALL file writes: settings, history, autosave, logs.

**Input Validation:**
- Validate ALL external input at system boundaries (user input, file loads, network messages)
- Reject or clamp out-of-range values — never trust loaded data
- Return safe defaults on parse failure (don't propagate exceptions from data loading)
- Log warnings for rejected input but don't crash

**XSS Prevention (web frontends):**
- Escape all user-controlled strings before inserting into HTML
- Use `textContent` not `innerHTML` for user data in JavaScript
- Sanitize category names, player names, and any other user-provided text

**Resource Cleanup:**
- Close file descriptors in all error paths
- Handle WebSocket/network disconnections gracefully
- Auto-reconnect with backoff on connection loss

### 5.2 Error Handling

**The Golden Rule:** Every function that reads external data should handle corruption gracefully.

```python
def load_settings(path: Path) -> dict:
    """Load settings, returning defaults on any failure."""
    try:
        data = json.loads(path.read_text())
        # Merge only known keys, ignore unknowns
        return {k: data.get(k, v) for k, v in DEFAULTS.items()}
    except (FileNotFoundError, json.JSONDecodeError, OSError):
        return dict(DEFAULTS)
```

**State Validation on Load:**
```python
def load_state(path: Path) -> Optional[State]:
    """Validate every field before reconstruction. Return None on any failure."""
    try:
        data = json.loads(path.read_text())
        # Validate structure
        if not isinstance(data.get("items"), list):
            return None
        # Validate values
        for item in data["items"]:
            if not (1 <= item.get("value", 0) <= 100):
                return None
        # Reconstruct only after full validation
        return State(...)
    except (KeyError, TypeError, ValueError, json.JSONDecodeError):
        return None
```

### 5.3 Accessibility (Web/GUI)

**Semantic HTML:**
- Use proper elements: `<header>`, `<main>`, `<table>` with `<thead>/<tbody>`, `<button>`
- Add `scope="col"` on table headers
- Use `role="dialog"` + `aria-modal="true"` + `aria-labelledby` on overlays

**Live Regions:**
- Use `aria-live="polite"` for status updates (turn changes, AI decisions)

**Keyboard Navigation:**
- All interactive elements reachable via Tab
- All actions have keyboard shortcuts
- Document shortcuts in a help overlay (? or F1)
- Handle Enter, Escape, arrows consistently

**Color Independence:**
- Every state conveyed by color MUST also have a non-color indicator:
  - Text label ("HELD", "Active", etc.)
  - Border/outline change
  - Pattern/texture change
- Provide a colorblind mode toggle

**WCAG AA Contrast:**
- Minimum 4.5:1 for normal text, 3:1 for large text
- Test both light and dark modes

**Touch Targets:**
- Minimum 44x44px for all interactive elements
- Add adequate spacing between targets on mobile

### 5.4 Responsive Design (Web)

- Mobile breakpoint (~768px): stack layouts, reduce sizes
- Touch event handling (touchstart with preventDefault to avoid double-fire)
- Event delegation for high-frequency DOM rebuilds (mousedown, not click)
- `{ passive: false }` on touch handlers that call preventDefault

### 5.5 Progressive Enhancement (Web)

- PWA manifest for installable app
- Service worker with stale-while-revalidate for static assets
- Disconnect banner with auto-reconnect
- Web Audio with lazy initialization (avoid autoplay policy violations)

### 5.6 Developer Experience

**README.md** must include:
- One-line project description
- Setup instructions (prerequisites, install commands)
- Usage examples for every entry point
- Controls/keyboard shortcuts table
- Feature list
- Architecture diagram (ASCII art showing module layers)
- Testing instructions with test count table
- Benchmarking instructions (if applicable)

**Makefile** targets:
```makefile
play:      # Run the app
test:      # Fast tests only
test-all:  # All tests including slow
coverage:  # With coverage report
bench:     # Benchmarks (if applicable)
setup:     # Install dependencies
clean:     # Remove generated files
```

**CI/CD** (.github/workflows/):
- Test across multiple runtime versions (e.g., Python 3.10-3.12)
- Run fast tests first (fail fast), slow tests separately
- Include coverage reporting
- Set up headless display if UI framework needs it (SDL_VIDEODRIVER=dummy)

**CLAUDE.md:**
- Document architecture with dependency rules
- List module responsibilities
- Specify development commands
- State conventions (commit style, test-before-commit, read-before-modify)

**.gitignore:**
- Cover ALL generated artifacts: __pycache__, .venv, .coverage, htmlcov/, .DS_Store, IDE files, build artifacts, tool caches

**pyproject.toml:**
- Optional dependencies grouped by feature (dev, tui, web, etc.)
- Coverage configuration with fail_under threshold
- Test markers for slow tests

### 5.7 Commit the Hardening

Hardening should be a series of focused commits:
```
Fix XSS in player name rendering
Make autosave writes atomic to prevent corruption on crash
Validate die values on autosave load to reject corrupted saves
Add focus indicators and ARIA attributes for accessibility
Improve color contrast to meet WCAG AA standards
Add try-catch for WebSocket JSON.parse to prevent client crash
```

Each commit message should explain WHAT was fixed and WHY (the "to prevent..." suffix pattern).

---

## Quality Checklist

Before declaring a codebase "perfect," verify all of these:

### Architecture
- [ ] Pure logic core with zero framework imports
- [ ] Immutable state (frozen dataclasses or equivalent)
- [ ] Pure functions return new state, never mutate
- [ ] Coordinator layer manages state machine without UI imports
- [ ] All frontends share adapter logic (no duplication)
- [ ] Dependency graph is a clean DAG (no upward or circular deps)

### Testing
- [ ] 80%+ branch coverage on core logic
- [ ] Tests organized in classes by behavioral topic
- [ ] Docstrings on test classes state the rule being tested
- [ ] Positive and negative test pairs for every behavior
- [ ] Helper functions (not fixtures) for test state construction
- [ ] Fast/slow split with CI running fast first
- [ ] Integration tests exercise the full stack headlessly
- [ ] All tests pass before every commit

### Security
- [ ] All file writes are atomic (tempfile + rename)
- [ ] All external data loads handle corruption gracefully
- [ ] All user input validated at system boundaries
- [ ] XSS prevention on all user-controlled strings in web output
- [ ] Resource cleanup in all error paths (file descriptors, connections)
- [ ] No sensitive data in error messages or logs

### Accessibility (Web/GUI)
- [ ] Semantic HTML with proper ARIA attributes
- [ ] aria-live regions for status updates
- [ ] Full keyboard navigation with documented shortcuts
- [ ] Color independence (every color-conveyed state has non-color alternative)
- [ ] WCAG AA contrast ratios in both light and dark modes
- [ ] 44px+ touch targets on mobile
- [ ] Colorblind mode toggle

### UX Polish
- [ ] Purposeful animations (feedback, not decoration)
- [ ] Dark mode with complete theme coverage
- [ ] Responsive layout with mobile breakpoint
- [ ] Graceful disconnect handling with auto-reconnect
- [ ] Error states shown to user (not silent failures)
- [ ] Undo support (trivial with immutable state)

### Developer Experience
- [ ] README with setup, usage, architecture, and testing docs
- [ ] Makefile with standard targets (test, coverage, clean, play)
- [ ] CI/CD across multiple runtime versions
- [ ] CLAUDE.md with architecture rules and conventions
- [ ] .gitignore covers all generated artifacts
- [ ] pyproject.toml with coverage thresholds and test markers

### Code Style
- [ ] Type hints on all function signatures
- [ ] Docstrings on public functions and classes
- [ ] Consistent naming (SCREAMING_SNAKE, PascalCase, snake_case, _private)
- [ ] Visual section separators in files >200 lines
- [ ] No dead code, no commented-out code, no TODO comments in shipped code

### Git Discipline
- [ ] Every commit message starts with imperative verb
- [ ] Every commit is a single logical change
- [ ] Every commit message is unique
- [ ] Tests included in same commit as the feature they test
- [ ] Security fixes explain what they prevent

---

## Execution Notes

- **Always read before modifying.** Never propose changes to code you haven't read.
- **Explain every change.** State WHY each modification is being made.
- **Test before committing.** Run the test suite after every change.
- **One commit per logical change.** Never bundle unrelated changes.
- **Phase order matters.** Architecture enables testing enables features enables hardening.
- **Ask before large changes.** If a phase would touch >10 files, present the plan first.
- **Language-agnostic principles, language-specific patterns.** The checklist applies to any language; adapt the specific patterns (frozen dataclasses, pyproject.toml, etc.) to the target language's ecosystem.
