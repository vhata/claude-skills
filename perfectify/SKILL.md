---
name: perfectify
description: Systematically analyze and improve any repository toward production-quality perfection. Audits architecture, testing, security, error handling, developer experience, and code quality, then executes improvements in the correct order. Works for any project type — libraries, CLIs, APIs, web apps, data pipelines, GUIs, or anything else.
---

# Perfectify

Systematically transform any existing repository into a production-quality exemplar. This skill applies universal software engineering principles — clean architecture, comprehensive testing, security, error handling, developer experience — adapted to whatever kind of project it finds.

## When to Use This Skill

- User asks to "perfectify", "make perfect", or "improve quality" of a repository
- User asks to audit and systematically improve a codebase
- User invokes `/perfectify`

## Philosophy: What Makes Software "Perfect"

Perfect software isn't about adding features — it's about getting every dimension right simultaneously. The eight universal pillars are:

1. **Architecture** — Clean separation of concerns, dependencies point inward, pure testable core
2. **Testing** — Tests as executable specification, comprehensive coverage, fast feedback
3. **Security** — Protect against adversarial misuse: injection, secrets exposure, unauthorized access, data leakage
4. **Error Handling** — Resilience under non-adversarial failure: corrupt files, timeouts, missing data, unexpected input
5. **Developer Experience** — README, task runner, CI/CD, CLAUDE.md, easy onboarding
6. **Code Quality** — Types, docs, linting, consistent style, clear organization
7. **Git Discipline** — Focused commits, clear messages, incremental development
8. **Interface Polish** — Whatever the project's interface is (API, CLI, UI, library API), make it excellent

Security and error handling overlap at "input validation" but address different threats. Security asks "what could an attacker exploit?" Error handling asks "what happens when things go wrong innocently?" Both are universal — every project has attack surface and failure modes.

Pillar 8 is project-type-specific. A library needs great API design and documentation. A CLI needs helpful error messages and exit codes. A web app needs accessibility and responsiveness. Pillars 1-7 are universal.

## Development Arc

Improvements follow a proven 5-phase arc. **Each phase enables the next**, so assess them in order — but skip any phase the audit shows is already excellent.

```
Phase 1: AUDIT        → Understand what exists, classify the project type
Phase 2: ARCHITECT    → Extract pure core, enforce separation
Phase 3: TEST         → Comprehensive test suite as specification
Phase 4: ENRICH       → Improve the project's OWN features on the solid foundation
Phase 5: HARDEN       → Security, robustness, polish for the project's interface type
```

---

## Phase 1: AUDIT

Read the entire codebase and produce a diagnosis. Do NOT make changes yet.

### 1.1 Classify the Project

First, determine what kind of project this is. It may be more than one:

| Type | Indicators |
|------|-----------|
| **Library/Package** | Exports functions/classes for other code to use, has a public API |
| **CLI Tool** | Has argument parsing, reads stdin/writes stdout, has exit codes |
| **Web Application** | Has HTTP routes, templates, frontend assets |
| **Web API/Service** | Has HTTP/gRPC endpoints, returns JSON/protobuf, has middleware |
| **GUI Application** | Has a window toolkit (Qt, Tk, Electron, pygame, etc.) |
| **Data Pipeline** | Reads data sources, transforms, writes to sinks |
| **Infrastructure/Config** | Terraform, Ansible, Docker, CI configs |
| **Monorepo** | Contains multiple sub-projects |

The project type determines which Phase 5 hardening checklist applies.

### 1.2 Architecture Audit

Map the dependency graph. Answer these questions:

- **Is there a pure core?** Can the essential logic be imported and called without any framework, I/O, network, or filesystem dependency?
- **Which direction do dependencies flow?** (Ideal: inward toward the pure core. Red flag: core importing from outer layers)
- **Are there circular dependencies?**
- **Where does state live?** Is it mutable or immutable? Is there global mutable state?
- **Where are the I/O boundaries?** (File system, network, database, user input, environment variables)
- **Is business logic tangled with I/O?** (Red flag: SQL queries or HTTP calls mixed into domain logic)

**Red flags (any project type):**
- Framework imports inside core logic modules
- Business logic inside I/O handlers (route handlers, CLI parsers, event handlers)
- Global mutable state shared across modules
- God objects that mix concerns (a class that does parsing AND validation AND persistence AND formatting)
- Circular imports

### 1.3 Testing Audit

- How many tests exist? What's the test-to-code ratio?
- What's the branch coverage? Is there a coverage threshold configured?
- Are tests organized by topic/module or randomly scattered?
- Do tests describe behavior (specification-style) or just poke at implementation details?
- Is there a fast/slow test split?
- Are there integration tests that exercise module boundaries?
- Can the full test suite run without external services (databases, APIs, network)?

### 1.4 Security Audit

- **Injection risks:** SQL injection? Command injection? Path traversal? Template injection? XSS? (Check based on what I/O the project does)
- **Secrets:** Are credentials, API keys, or tokens hardcoded or committed? Are `.env` and credential files in .gitignore?
- **Authentication/Authorization:** Are protected operations actually protected? Can access controls be bypassed?
- **Data exposure:** Do error messages, logs, or API responses leak sensitive information (stack traces, internal paths, user data)?
- **Dependencies:** Are there known vulnerabilities in dependencies? Are dependency versions pinned?
- **Input trust:** Is any external input (user, file, network, environment) used without sanitization in a dangerous context (shell commands, SQL, HTML, file paths)?

### 1.5 Error Handling Audit

- **File I/O:** Do reads handle missing/corrupt files gracefully? Are writes atomic (tempfile + rename)?
- **External services:** What happens when a database, API, or network connection is unavailable or slow?
- **Malformed input:** Does the system crash or degrade gracefully on unexpected data types, missing fields, or out-of-range values?
- **Resource cleanup:** Are file handles, connections, and processes cleaned up in error paths?
- **Error propagation:** Do errors bubble up with useful context, or are they swallowed silently? Do they crash the whole process when they shouldn't?
- **Recovery:** Can the system recover from interruption (SIGKILL, power loss, OOM)? Does it leave corrupt state behind?

### 1.6 Developer Experience Audit

- Is there a README with: project description, prerequisites, setup instructions, usage examples?
- Is there a task runner (Makefile, justfile, npm scripts, etc.) with common targets?
- Is there CI/CD? Does it test across multiple runtime versions?
- Is there a CLAUDE.md documenting architecture and conventions for AI agents?
- Is there a .gitignore covering all generated artifacts for this language/framework?
- Is the dependency/build configuration (pyproject.toml, package.json, Cargo.toml, go.mod, etc.) properly set up with dev dependencies, coverage thresholds, linter config?

### 1.7 Code Quality Audit

- Are there type annotations / type hints on function signatures? (Or equivalent: JSDoc, TypeScript types, Go's type system, Rust's type system)
- Are there docstrings / doc comments on public functions, classes, and modules?
- Is naming consistent? (Follow the language's conventions: snake_case for Python/Rust, camelCase for JS/Go, etc.)
- Is there clear visual organization in longer files? (Section comments, logical grouping)
- Is there dead code, commented-out code, or stale TODO comments?
- Is a linter configured and passing? A formatter? (ruff, eslint, rustfmt, gofmt, etc.)

### 1.8 Git Discipline Audit

- Do commit messages follow a consistent convention? (Imperative verb-first is the standard)
- Are commits focused on single logical changes, or do they bundle unrelated work?
- Are there giant commits that should have been split?
- Are tests committed alongside the code they test?
- Is there a clean branch strategy? (main protected, feature branches, etc.)

### 1.9 Present Findings

Present a scorecard to the user with grades and one-line summaries:

```
Project type:     [classification]
Architecture:     [A/B/C/D/F] — ...
Testing:          [A/B/C/D/F] — ...
Security:         [A/B/C/D/F] — ...
Error Handling:   [A/B/C/D/F] — ...
Dev Experience:   [A/B/C/D/F] — ...
Code Quality:     [A/B/C/D/F] — ...
Git Discipline:   [A/B/C/D/F] — ...
[Type-specific]:  [A/B/C/D/F] — ... (e.g., "API Design", "CLI UX", "Accessibility")
```

Based on the grades, **recommend which phases would have the highest impact** and suggest a priority order. Then ask the user which phases to proceed with — they may have different priorities.

---

## Phase 2: ARCHITECT

Extract a pure, testable core. This is the most important phase — it enables everything else.

### 2.1 Identify the Pure Core

Every project has domain logic that is independent of how it's delivered:

| Project Type | Pure Core Contains |
|---|---|
| **Library** | The library's own logic (may already be well-structured) |
| **CLI** | The operations the CLI performs, minus argument parsing and output formatting |
| **Web API** | Business logic, validation rules, domain models — minus HTTP/routing |
| **Web App** | Same as API + any client-side state logic, minus rendering/DOM |
| **GUI App** | Game/app logic, state transitions — minus window toolkit |
| **Data Pipeline** | Transform logic, validation rules — minus I/O connectors |
| **Infra/Config** | Validation logic, config generation/templating — minus cloud API calls |
| **Monorepo** | Apply per sub-project — each has its own pure core |

### 2.2 Extract the Core

Refactor so the core module(s):
- Have **ZERO imports** from frameworks, I/O libraries, or delivery mechanisms
- Use the language's type system to make invalid states unrepresentable where possible
- Prefer **immutable data structures** for state (frozen dataclasses, readonly records, const structs, etc.)
- Expose **pure functions** that take inputs and return outputs without side effects
- Can be imported and called from a test file with no setup, no running server, no database

**Why immutability matters:** Immutable state + pure functions means no hidden side effects, trivial unit testing, easy snapshotting/undo, safe concurrency, and simple serialization. This applies to any project — API request processing, data pipeline transforms, CLI operations, library functions.

### 2.3 Push I/O to the Edges

Restructure so I/O happens at the outermost layer:

```
PURE CORE (logic, validation, transforms, domain rules)
    ↑ depends on nothing external
    │
ORCHESTRATION (coordinates core operations, manages state/lifecycle)
    ↑ depends on core only
    │
I/O BOUNDARY (HTTP handlers, CLI parsers, file readers, DB queries, UI renderers)
    ↑ depends on orchestration + core
```

The number of layers depends on the project's complexity. A small CLI might only need core + I/O boundary. A large application might need core + orchestration + adapters + delivery.

**The key rule:** Dependencies ONLY point inward (toward the core). The core never imports from outer layers.

### 2.4 Define Interfaces at Boundaries

Where the core needs to interact with external systems, define abstract interfaces:
- The core depends on the interface (abstract class, protocol, trait, interface)
- The outer layer provides the concrete implementation
- This enables testing the core with fakes/stubs instead of real I/O

### 2.5 Verify Separation

- Search the core module(s) for framework imports — there should be none
- Confirm the core can be imported in a bare Python/Node/etc. environment without installing frameworks
- Draw the dependency graph and confirm arrows only point inward

### 2.6 Commit

One commit per extraction step. Imperative verb-first message:
```
Extract domain logic into core module
Push database queries to repository boundary
Define storage interface for dependency inversion
```

---

## Phase 3: TEST

Write tests as an executable specification of the system's behavior.

### 3.1 Test Organization

Group tests by behavioral topic, not by implementation detail. (Examples below use Python syntax — adapt to the project's language and test framework.)

```
# Good: tests describe WHAT the system does
class TestOrderPricing:
    """Rule: Orders over $100 get free shipping, otherwise $9.99."""
    def test_free_shipping_over_threshold(self): ...
    def test_standard_shipping_under_threshold(self): ...
    def test_exact_threshold_gets_free_shipping(self): ...

# Bad: tests describe HOW the code works
class TestCalculateShippingFunction:
    def test_returns_zero(self): ...
    def test_returns_999(self): ...
```

**Conventions:**
- Group tests into classes by behavioral topic, with a docstring stating the rule being tested
- Name tests `test_<descriptive_action>` — they should read like specifications
- Write **positive AND negative test pairs** systematically (what it does AND what it rejects)
- Use **helper/factory functions** for test data construction — explicit and readable
- **Only mock at I/O boundaries** — never mock internal code

### 3.2 Test Helpers

Create helper functions that construct test data with sensible defaults:

```
# Good: explicit helper, caller sees what matters
def make_order(total=50.00, items=None):
    return Order(total=total, items=items or [default_item()])

# Bad: pytest fixture hidden in conftest, magic injection
@pytest.fixture
def order():
    return Order(...)
```

Why helpers over fixtures: Fixtures hide setup in conftest files and use name-based injection. Helpers are explicit function calls visible at the test site. When a test breaks, you can read it top to bottom and understand it without chasing fixture definitions.

### 3.3 Coverage Target

- **80%+ branch coverage** on the pure core
- Configure a coverage threshold in the project's test config so CI fails if coverage drops
- Omit from coverage: test files themselves, entry points with I/O (main.py, CLI entry, etc.)
- Use branch coverage, not just line coverage

### 3.4 Fast/Slow Split

Separate tests that run in milliseconds from those that take seconds:

- **Fast (default):** Unit tests of pure logic, should complete in <10 seconds total
- **Slow (opt-in):** Integration tests, property-based tests, end-to-end tests, benchmarks

Configure so `make test` runs fast tests only, `make test-all` runs everything. CI should run fast tests first (fail fast), then slow tests in a separate step.

### 3.5 Integration Tests

Write at least a few tests that exercise module boundaries together:
- For an API: test that a request flows through routing → validation → business logic → response
- For a CLI: test that arguments parse → execute → produce expected output
- For a library: test that the public API works end-to-end for common workflows
- For a pipeline: test that data flows through all transform stages correctly

### 3.6 Commit

```
Add comprehensive test suite for core module (N tests)
Add integration tests for API endpoints
Configure coverage threshold at 80%
Mark slow tests for CI separation
```

---

## Phase 4: ENRICH

This phase is about improving the project's OWN goals — not adding prescribed features. The architecture and test foundation from Phases 2-3 makes this safe and fast.

### 4.1 Assess What the Project Needs

Based on the audit findings and the project's purpose, identify what would make it more complete, more robust, or more useful. **Present the list to the user and ask them to prioritize** — don't assume what matters most. Common categories:

**Completeness:** Are there features the project should have but doesn't? Edge cases it doesn't handle? Modes it should support? Look at the project's own documentation, issue tracker, and README for clues about intended scope.

**Robustness:** Are there failure modes that aren't handled? Can it recover from interruption? Does it handle concurrent access? What happens at the edges (empty input, huge input, zero items, max values)?

**Performance:** Are there obvious bottlenecks? Can expensive computations be cached or precomputed? Are there N+1 queries, unbounded loops, or missing indexes?

**Observability:** Can you tell what the program is doing? Is there structured logging? Metrics? Debug output? Can you diagnose a production issue from the logs alone?

### 4.2 Feature Development Pattern

For every change, follow the same layering:
1. **Core first** — Add/modify pure logic + tests
2. **Orchestration next** — Wire into coordination layer + tests
3. **I/O / delivery last** — Update the interface (API response, CLI output, UI, etc.)
4. **One commit per logical change**

### 4.3 Commit Discipline

Every commit should:
- Start with an imperative verb (Add, Fix, Update, Remove, Refactor, Extract, Implement)
- Describe a single logical change
- Be unique — no duplicate messages across the entire history
- Include test count when adding tests: "Add order validation with 23 tests"

---

## Phase 5: HARDEN

The final pass makes everything production-quality. Apply the universal hardening first, then the type-specific checklist.

### 5.1 Security Hardening (All Projects)

**No Secrets in Code:**
- No hardcoded credentials, API keys, tokens, or passwords
- Use environment variables or secret managers
- Ensure `.env` files, credential files, and private keys are in `.gitignore`
- Audit git history for accidentally committed secrets

**Input Sanitization:**
- Identify every point where external data enters a dangerous context (shell commands, SQL, HTML, file paths, deserialization) and sanitize appropriately
- Use parameterized queries, not string concatenation, for SQL
- Escape user-controlled strings before inserting into HTML/templates
- Never pass user input directly to shell commands; use language APIs that avoid shell interpretation
- Validate file paths against traversal (`../`) before opening

**The validation pattern:** Parse, don't validate. Transform raw input into validated domain types at the boundary. Code inside the boundary only works with validated types.

| Boundary | What to Validate |
|----------|----------|
| CLI arguments | Types, ranges, file existence, mutually exclusive flags |
| Environment variables | Presence, format, ranges |
| File reads | Existence, permissions, format, schema, value ranges |
| API request bodies | Required fields, types, ranges, string lengths |
| Database results | Missing rows, null fields, schema drift |
| Network messages | Malformed payloads, unexpected message types |
| User input (UI) | Everything — never trust client-side validation alone |

**Dependency Security:**
- Check for known vulnerabilities in dependencies (e.g., `npm audit`, `pip-audit`, `cargo audit`)
- Pin dependency versions or use lock files
- Minimize the dependency tree — fewer deps means less attack surface

**Access Control:**
- If the project has any notion of users/roles/permissions, verify that authorization checks can't be bypassed
- Ensure sensitive operations require authentication before business logic executes

### 5.2 Error Handling Hardening (All Projects)

**Atomic File Writes:**

If the project writes files (config, state, output), ensure writes are atomic: write to a temp file in the same directory, then rename. This prevents corruption if the process is killed mid-write. Use the language's standard library (e.g., Python's `tempfile.mkstemp` + `os.replace`, Go's `os.Rename`, Rust's `tempfile` crate).

**Graceful Degradation:**
- Loading/parsing functions return safe defaults on corruption — don't propagate parse exceptions upward
- Validate every field of serialized state before reconstruction; return None/null/error on any invalid field
- Log warnings for rejected or unexpected input, but never crash the process

**Resource Cleanup:**
- Close file handles, database connections, network sockets in ALL code paths (including error paths)
- Use language idioms: Python's `with`, Go's `defer`, Rust's RAII/Drop, JavaScript's `try/finally`
- Handle interruption signals (SIGINT, SIGTERM) gracefully — clean up temp files, finish in-flight work

**Error Context:**
- Errors should carry enough context to diagnose the problem (which file? which field? what value?)
- But never include sensitive data (passwords, tokens, PII) in error messages or logs
- Use structured error types, not generic strings, so callers can handle different failures differently

**Timeout and Retry:**
- All network calls and external service interactions should have timeouts
- Retries should use backoff to avoid thundering herds
- Make it clear which operations are idempotent (safe to retry) and which aren't

### 5.3 Developer Experience Hardening (All Projects)

**README.md** must include:
- One-line project description
- Prerequisites and setup instructions
- Usage examples for the primary workflow
- Architecture overview (even a few sentences about module structure helps)
- How to run tests
- How to contribute (if applicable)

**Task Runner** (Makefile, justfile, npm scripts, etc.):
- `test` — Run fast tests
- `test-all` — Run all tests including slow
- `coverage` — Run with coverage report
- `lint` / `check` — Run linters and type checkers
- `clean` — Remove generated artifacts
- A run/build/serve target appropriate to the project type

**CI/CD:**
- Test across multiple runtime versions where relevant
- Run linters and type checkers
- Run fast tests first (fail fast), slow tests separately
- Include coverage reporting with a threshold

**CLAUDE.md:**
- Document the architecture and its dependency rules
- List each module's responsibility in one line
- Specify how to run, test, and build
- State conventions (commit style, test-before-commit, read-before-modify)

**.gitignore:**
- Cover ALL generated artifacts for this language's ecosystem
- Include OS files (.DS_Store, Thumbs.db), IDE files (.vscode, .idea), build output, coverage output, virtual environments, caches

**Dependency Configuration:**
- Separate dev dependencies from production dependencies
- Pin or constrain dependency versions appropriately
- Configure linter, formatter, type checker, and coverage settings

### 5.4 Code Quality Hardening (All Projects)

**Type Annotations:**
- Add type hints / type annotations to all function signatures (parameters and return types)
- Focus on public API surfaces first, then internal functions
- Use the language's idiomatic approach (Python type hints, TypeScript types, JSDoc, Go's type system, etc.)

**Documentation:**
- Add doc comments to all public functions, classes, and modules
- Focus on *what* and *why*, not *how* — the code shows how
- Document non-obvious parameters, return values, and error conditions

**Linting and Formatting:**
- Configure a linter and formatter for the language (ruff for Python, eslint/prettier for JS/TS, clippy/rustfmt for Rust, etc.)
- Fix all linter warnings — either fix the issue or explicitly suppress with a comment explaining why
- Ensure CI runs the linter so violations can't be merged

**Dead Code Removal:**
- Remove unused imports, functions, classes, and variables
- Remove commented-out code — it's in version control if anyone needs it
- Remove stale TODO/FIXME comments — either do the task or delete the comment

### 5.5 Type-Specific Hardening

Apply the relevant checklist(s) based on the project classification from Phase 1:

#### For Libraries/Packages

- [ ] Public API is minimal — only expose what users need
- [ ] All public functions/classes have docstrings with examples
- [ ] Type signatures on all public API surfaces
- [ ] Backward compatibility considered (or version bump documented)
- [ ] No unnecessary dependencies (keep the dep tree small)
- [ ] Errors use well-defined exception/error types (not generic strings)
- [ ] Examples directory or inline examples in docs

#### For CLI Tools

- [ ] `--help` text is complete and well-formatted for every command/subcommand
- [ ] Meaningful exit codes (0 for success, non-zero for different failure types)
- [ ] Errors print to stderr, output prints to stdout
- [ ] Graceful handling of SIGINT (Ctrl+C) — clean up temp files, don't print stack traces
- [ ] Handles stdin/stdout piping correctly (detect TTY, don't print color to pipes)
- [ ] Input validation with clear, actionable error messages ("Expected a number for --count, got 'abc'")
- [ ] Progress indicators for long operations (if output is a TTY)
- [ ] Respects NO_COLOR and TERM environment variables

#### For Web APIs/Services

- [ ] All endpoints validate request input (types, ranges, required fields)
- [ ] Consistent error response format (error code, message, details)
- [ ] Authentication/authorization checked before business logic
- [ ] Rate limiting on public endpoints
- [ ] Request logging with correlation IDs
- [ ] Graceful shutdown (finish in-flight requests before exiting)
- [ ] Health check endpoint
- [ ] No sensitive data in logs or error responses
- [ ] SQL injection prevention (parameterized queries, ORM)
- [ ] CORS configured appropriately (not `*` in production)

#### For Web Applications (with a UI)

- [ ] Semantic HTML with proper ARIA attributes
- [ ] Full keyboard navigation with documented shortcuts
- [ ] WCAG AA color contrast (4.5:1 normal text, 3:1 large text)
- [ ] Color independence — every color-conveyed state has a non-color alternative
- [ ] Minimum 44x44px touch targets on mobile
- [ ] Responsive layout with mobile breakpoint
- [ ] XSS prevention — escape all user-controlled strings in HTML output
- [ ] CSRF protection on state-changing requests
- [ ] Graceful handling of network errors (show status, retry)
- [ ] `aria-live` regions for dynamic status updates
- [ ] Works without JavaScript for core functionality (progressive enhancement) where feasible

#### For GUI Applications (native)

- [ ] All logic separated from the window toolkit (pure core testable headlessly)
- [ ] Keyboard shortcuts for all primary actions, documented in a help overlay or menu
- [ ] Responsive to window resizing without layout breakage
- [ ] Accessible labels on interactive elements (for screen readers where the toolkit supports it)
- [ ] Color not used as the sole indicator of state — pair with text, icons, or borders
- [ ] Graceful handling of missing assets or failed resource loading
- [ ] No blocking I/O on the main/UI thread

#### For Data Pipelines

- [ ] Idempotent operations — running twice produces the same result
- [ ] Checkpointing — can resume from failure without reprocessing everything
- [ ] Input validation — rejects malformed records with clear error reports
- [ ] Logging with record counts, timing, and error rates
- [ ] Handles schema evolution gracefully (new fields, missing fields)
- [ ] Backpressure handling — doesn't OOM on large inputs
- [ ] Dry-run mode for testing without side effects

#### For Infrastructure/Config

- [ ] Idempotent operations
- [ ] Dry-run / plan mode before applying changes
- [ ] Secrets managed through variables, not hardcoded
- [ ] Rollback strategy documented
- [ ] Environment-specific configuration separated from shared config

#### For Monorepos

- [ ] Each sub-project can be built and tested independently
- [ ] Shared dependencies are managed consistently (workspace, shared lockfile, etc.)
- [ ] CI runs only affected sub-projects on change (not the entire repo every time)
- [ ] Clear ownership boundaries — each sub-project has its own README and CLAUDE.md
- [ ] Apply the relevant type-specific checklist to each sub-project individually

---

## Quality Checklist (Universal)

Before declaring a codebase "perfect," verify all of these:

### Architecture
- [ ] Pure core module(s) with zero framework/I/O imports
- [ ] Dependencies only point inward (toward the core)
- [ ] No circular dependencies
- [ ] I/O pushed to the outermost layer
- [ ] Interfaces defined at boundaries for testability
- [ ] State management is predictable (prefer immutability)

### Testing
- [ ] 80%+ branch coverage on core logic
- [ ] Tests organized by behavioral topic with descriptive names
- [ ] Positive and negative test pairs for every behavior
- [ ] Helper functions for test data construction (not hidden fixtures)
- [ ] Fast/slow split — fast tests complete in seconds
- [ ] Integration tests exercise module boundaries
- [ ] All tests pass, coverage threshold enforced in CI

### Security
- [ ] No secrets (credentials, keys, tokens) in code or version control
- [ ] All external input sanitized before use in dangerous contexts (SQL, shell, HTML, file paths)
- [ ] Injection prevention appropriate to every I/O type the project uses
- [ ] Dependencies checked for known vulnerabilities
- [ ] Access controls enforced and not bypassable (if applicable)
- [ ] No sensitive data leaked in error messages, logs, or responses

### Error Handling
- [ ] Every I/O boundary validates its input (types, ranges, required fields)
- [ ] File writes are atomic where data loss matters
- [ ] External data loads handle corruption gracefully (safe defaults, not crashes)
- [ ] Resources cleaned up in all code paths (including errors)
- [ ] Errors carry diagnostic context without exposing sensitive data
- [ ] Network operations have timeouts; retries use backoff

### Developer Experience
- [ ] README with setup, usage, architecture overview, and test instructions
- [ ] Task runner with standard targets (test, lint, clean, build/run)
- [ ] CI/CD across multiple runtime versions with coverage threshold
- [ ] CLAUDE.md with architecture rules, module map, and conventions
- [ ] .gitignore covers all generated artifacts
- [ ] Dependency config with dev/prod separation and tool settings

### Code Quality
- [ ] Type annotations on function signatures (in the language's idiom)
- [ ] Doc comments on public API surfaces
- [ ] Linter and formatter configured, passing, and enforced in CI
- [ ] Consistent naming following language conventions
- [ ] Clear organization in longer files
- [ ] No dead code, commented-out code, or stale TODOs

### Git Discipline
- [ ] Every commit message starts with imperative verb
- [ ] Every commit is a single logical change
- [ ] Every commit message is unique and descriptive
- [ ] Tests accompany the code they test (same commit)
- [ ] Security/robustness fixes explain what they prevent

### Interface Polish (type-specific)
- [ ] Relevant type-specific checklist from Phase 5.5 completed

---

## Execution Notes

- **Always read before modifying.** Never propose changes to code you haven't read.
- **Explain every change.** State WHY each modification is being made.
- **Test before committing.** Run the test suite after every change.
- **One commit per logical change.** Never bundle unrelated changes.
- **Phase order matters.** Architecture enables testing. Testing enables safe enrichment. Enrichment is hardened last.
- **Ask before large changes.** If a phase would touch >10 files, present the plan first.
- **Adapt to the language.** The principles are universal; the patterns are language-specific. Use frozen dataclasses in Python, readonly records in C#, const structs in Go, etc. Use pyproject.toml for Python, package.json for Node, Cargo.toml for Rust, etc.
- **Adapt to the project type.** A 200-line CLI script needs less ceremony than a multi-service application. Scale the rigor to the project's size and purpose. A tiny project might skip the orchestration layer. A massive one might need multiple.
- **Don't add what isn't needed.** Perfectifying means making what exists excellent, not bolting on features the project doesn't need. A CLI tool doesn't need accessibility auditing. A library doesn't need a Makefile `play` target. Read the project, understand its purpose, and improve what matters.
