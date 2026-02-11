---
name: pyrepo
description: create a modern Python repository with best practices
---

Create a brand-new Python repository with modern tooling (uv, pytest, ruff, mypy, pre-commit) and sensible defaults.

## Step 1: Prerequisites Check

Before starting, verify all required tools are installed:

**git**: Run `git --version`
- If missing: "ERROR: git not installed. Install from: https://git-scm.com/downloads"

**python**: Run `python --version` or `python3 --version` (require 3.10+)
- If missing/old: "ERROR: Python 3.10+ required. Install from: https://www.python.org/downloads/"

**uv**: Run `uv --version`
- If missing: "ERROR: uv not installed. Install with: curl -LsSf https://astral.sh/uv/install.sh | sh"

If all prerequisites are met, display: "✓ All prerequisites found. Proceeding with setup..."

## Step 2: Gather Project Parameters

Ask the user for:
- **Project name** (e.g., "my-awesome-project")
- **Package name** (default: snake_case version of project name)
- **Python version** (default: 3.12)
- **License** (default: MIT)

Display the parameters and confirm before proceeding.

## Step 3: Repository Layout

Create this structure in the current directory:

```
.
├── .claude/
│   └── CLAUDE.md
├── .editorconfig
├── .gitignore
├── .pre-commit-config.yaml
├── CHANGELOG.md
├── LICENSE
├── Makefile
├── README.md
├── pyproject.toml
├── src/
│   └── {package_name}/
│       ├── __init__.py
│       └── core.py
├── tests/
│   ├── __init__.py
│   └── test_core.py
└── .github/
    └── workflows/
        └── ci.yml
```

## Step 4: File Contents

### .claude/CLAUDE.md
```markdown
# Claude Code Instructions for {PROJECT_NAME}

This file contains project-specific instructions for Claude Code when working in this repository.

## Commit Guidelines

### Commit Frequency
- Make small, focused commits regularly rather than large, monolithic commits
- Each commit should represent a single logical change
- Commit after completing each distinct task or fix

### Commit Message Format
Use descriptive commit messages that explain both what changed and why:

```
Short summary (50 chars or less)

More detailed explanation if needed. Wrap at 72 characters.
Explain the problem this commit solves and why this approach was taken.

- Bullet points are fine for listing multiple changes
- Reference issue numbers if applicable (#123)
```

Examples of good commit messages:
- `Add input validation for email field` (not just "fix bug")
- `Refactor user authentication to use JWT tokens` (not just "refactor auth")
- `Optimize database queries in user search` (not just "performance")

### What to Commit
- Always run `make format` and `make check` before committing
- Ensure all tests pass
- Ensure type checking passes (mypy)
- Pre-commit hooks will enforce these automatically

## CHANGELOG.md Maintenance

### When to Update CHANGELOG.md
Update CHANGELOG.md for changes that affect users or developers of this project:

**Always update for:**
- New features or functionality
- Bug fixes
- Breaking changes
- Deprecations
- Security fixes
- Performance improvements
- Dependency updates (major versions)

**Don't update for:**
- Refactoring that doesn't change behavior
- Code formatting
- Documentation typos
- Internal test changes
- Build configuration tweaks

### How to Update CHANGELOG.md
1. Add entries under `## [Unreleased]` section
2. Use the appropriate category:
   - `### Added` - New features
   - `### Changed` - Changes in existing functionality
   - `### Deprecated` - Soon-to-be removed features
   - `### Removed` - Removed features
   - `### Fixed` - Bug fixes
   - `### Security` - Security fixes

3. Write clear, user-focused descriptions
4. Update CHANGELOG.md in the same commit as the change

Example:
```markdown
## [Unreleased]

### Added
- Email validation for user registration form
- Support for Python 3.13

### Fixed
- Handle edge case where empty strings caused crashes in parser
```

## Testing Requirements
- Write tests for new functionality
- Update tests when changing existing functionality
- Aim for >80% code coverage
- Run `make test` before committing

## Code Style
- Follow PEP 8 (enforced by ruff)
- Use type hints for all function signatures (enforced by mypy)
- Write docstrings for public functions and classes
- Keep functions focused and small

## Review Before Committing
Before each commit, verify:
1. [ ] Code is formatted (`make format`)
2. [ ] Linting passes (`make lint`)
3. [ ] Type checking passes (`make type`)
4. [ ] Tests pass (`make test`)
5. [ ] CHANGELOG.md updated if appropriate
6. [ ] Commit message is descriptive
```

### .editorconfig
```
root = true

[*]
charset = utf-8
end_of_line = lf
insert_final_newline = true
indent_style = space
indent_size = 4
trim_trailing_whitespace = true

[*.md]
trim_trailing_whitespace = false
```

### .gitignore
```
# Python
__pycache__/
*.py[cod]
*.pyd
*.so
*.egg-info/
build/
dist/

# Virtualenv
.venv/

# Tooling caches
.pytest_cache/
.mypy_cache/
.ruff_cache/
.coverage
htmlcov/

# OS/editor
.DS_Store
.vscode/
.idea/
```

### LICENSE
Use MIT license with current year and author "Jonathan":
```
MIT License

Copyright (c) {YEAR} Jonathan

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

### CHANGELOG.md
```
# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Initial project setup
```

### README.md
```
# {PROJECT_NAME}

A Python project bootstrapped with modern tooling:

- **uv** - Fast dependency and environment management
- **pytest** - Testing framework with coverage
- **ruff** - Lightning-fast linting and formatting
- **mypy** - Static type checking
- **pre-commit** - Automated checks before commits
- **GitHub Actions** - Continuous integration

## Prerequisites

- Python {PYTHON_VERSION}+
- uv (install: `curl -LsSf https://astral.sh/uv/install.sh | sh`)

## Quickstart

```bash
# Create virtual environment and install dependencies
uv venv .venv
uv sync --group dev

# Install pre-commit hooks
uv run pre-commit install

# Run all checks
make check
```

## Development

### Common Commands

```bash
make format     # Auto-format code with ruff
make lint       # Run ruff linter
make type       # Type check with mypy
make test       # Run test suite
make check      # Run all checks (CI equivalent)
```

### Running Tests

```bash
# Run all tests with coverage
uv run pytest

# Run specific test file
uv run pytest tests/test_core.py

# Run with verbose output
uv run pytest -v
```

## Project Structure

```
src/{PACKAGE_NAME}/     # Source code
tests/                  # Test files
.github/workflows/      # CI configuration
.claude/                # Claude Code configuration
```

## Working with Claude Code

This repository includes a `.claude/CLAUDE.md` file with project-specific instructions for Claude Code, including:
- Commit message guidelines
- When to update CHANGELOG.md
- Testing requirements
- Code style preferences

## License

{LICENSE_TYPE} - see LICENSE file for details
```

### Makefile
```
.PHONY: help sync format lint type test check precommit

help:
	@echo "Available targets:"
	@echo "  sync       - Install/update dependencies"
	@echo "  precommit  - Install pre-commit hooks"
	@echo "  format     - Format code with ruff"
	@echo "  lint       - Lint code with ruff"
	@echo "  type       - Type check with mypy"
	@echo "  test       - Run test suite"
	@echo "  check      - Run all checks (format, lint, type, test)"

sync:
	uv sync --group dev

precommit:
	uv run pre-commit install

format:
	uv run ruff format .

lint:
	uv run ruff check .

type:
	uv run mypy .

test:
	uv run pytest

check:
	uv run ruff format --check .
	uv run ruff check .
	uv run mypy .
	uv run pytest
```

### pyproject.toml
Replace {PROJECT_NAME}, {PACKAGE_NAME}, and {PYTHON_VERSION}:
```toml
[project]
name = "{PROJECT_NAME}"
version = "0.1.0"
description = ""
readme = "README.md"
requires-python = ">={PYTHON_VERSION}"
dependencies = []

[dependency-groups]
dev = [
  "mypy>=1.10",
  "pre-commit>=3.7",
  "pytest>=8.0",
  "pytest-cov>=5.0",
  "ruff>=0.6",
]

[tool.pytest.ini_options]
testpaths = ["tests"]
addopts = ["-q", "--cov={PACKAGE_NAME}", "--cov-report=term-missing:skip-covered"]

[tool.coverage.run]
branch = true
source = ["{PACKAGE_NAME}"]

[tool.mypy]
python_version = "{PYTHON_VERSION}"
warn_unused_configs = true
disallow_untyped_defs = true
disallow_incomplete_defs = true
check_untyped_defs = true
no_implicit_optional = true
warn_redundant_casts = true
warn_unused_ignores = true
warn_return_any = true
strict_equality = true

[tool.ruff]
target-version = "py{PYTHON_VERSION_SHORT}"
line-length = 100

[tool.ruff.lint]
select = ["E", "F", "I", "B", "UP", "SIM", "RUF"]
```

### .pre-commit-config.yaml
```yaml
repos:
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v4.6.0
    hooks:
      - id: end-of-file-fixer
      - id: trailing-whitespace
      - id: check-toml
      - id: check-yaml
      - id: check-added-large-files

  - repo: https://github.com/astral-sh/ruff-pre-commit
    rev: v0.6.9
    hooks:
      - id: ruff
        args: ["--fix"]
      - id: ruff-format

  - repo: https://github.com/pre-commit/mirrors-mypy
    rev: v1.10.0
    hooks:
      - id: mypy
        additional_dependencies: []
```

### src/{PACKAGE_NAME}/__init__.py
```python
from .core import add

__all__ = ["add"]
```

### src/{PACKAGE_NAME}/core.py
```python
def add(a: int, b: int) -> int:
    """Add two integers and return the result."""
    return a + b
```

### tests/__init__.py
```python
# Intentionally empty.
```

### tests/test_core.py
```python
from {PACKAGE_NAME} import add


def test_add() -> None:
    """Test that add function works correctly."""
    assert add(1, 2) == 3
    assert add(-1, 1) == 0
    assert add(0, 0) == 0
```

### .github/workflows/ci.yml
```yaml
name: CI

on:
  push:
  pull_request:

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - uses: actions/setup-python@v5
        with:
          python-version: "{PYTHON_VERSION}"

      - name: Install uv
        uses: astral-sh/setup-uv@v3

      - name: Sync dependencies
        run: uv sync --group dev

      - name: Run checks
        run: |
          uv run ruff format --check .
          uv run ruff check .
          uv run mypy .
          uv run pytest
```

## Step 5: Initialize Repository

Execute these commands:

1. Initialize git with main branch:
   ```bash
   git init -b main
   ```

2. Create virtual environment and install dependencies:
   ```bash
   uv venv .venv
   uv sync --group dev
   ```

3. Install pre-commit hooks:
   ```bash
   uv run pre-commit install
   ```

## Step 6: Verification

Run the full check suite to ensure everything works:

```bash
make check
```

This runs:
- ✓ Format check (ruff format --check)
- ✓ Linting (ruff check)
- ✓ Type checking (mypy)
- ✓ Tests (pytest with coverage)

All checks must pass before proceeding.

## Step 7: Initial Commit

Create the initial commit:
```bash
git add .
git commit -m "Initial project setup

- Configure uv for dependency management
- Set up pytest, ruff, mypy
- Add pre-commit hooks
- Include GitHub Actions CI"
```

## Step 8: Success Summary

Display:
- ✓ Repository initialized successfully
- File tree created
- Commands that were run
- Next steps:
  - Review `.claude/CLAUDE.md` for project-specific Claude Code guidelines
  - `make help` - See all available commands
  - `make test` - Run tests
  - `make format` - Format code
  - Start coding in `src/{PACKAGE_NAME}/`

Note: The `.claude/CLAUDE.md` file contains instructions for Claude Code about:
- Making small, focused commits with descriptive messages
- Updating CHANGELOG.md for user-facing changes
- Running checks before committing

## Implementation Notes

- Replace all placeholders: {PROJECT_NAME}, {PACKAGE_NAME}, {PYTHON_VERSION}, {PYTHON_VERSION_SHORT}, {YEAR}, {LICENSE_TYPE}
- Use the current year (2026) for the license
- For PYTHON_VERSION_SHORT, convert "3.12" to "312"
- Validate that the package name is a valid Python identifier
- If any step fails, stop and display a clear error message
- Show progress as you work through each step
