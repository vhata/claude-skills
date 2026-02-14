---
name: webrepo
description: create a modern TypeScript web project with best practices
---

Create a brand-new TypeScript web project with modern tooling (Vite, React, Biome, Vitest, pnpm) and sensible defaults.

## Step 1: Prerequisites Check

Before starting, verify all required tools are installed:

**git**: Run `git --version`
- If missing: "ERROR: git not installed. Install from: https://git-scm.com/downloads"

**node**: Run `node --version` (require 18.0+)
- If missing/old: "ERROR: Node.js 18+ required. Install from: https://nodejs.org/"

**pnpm**: Run `pnpm --version`
- If missing: "ERROR: pnpm not installed. Install with: npm install -g pnpm"

If all prerequisites are met, display: "✓ All prerequisites found. Proceeding with setup..."

## Step 2: Gather Project Parameters

Ask the user for:
- **Project name** (e.g., "my-awesome-app")
- **Package name** (default: kebab-case version of project name)
- **Framework** (options: React [default], Vue, Vanilla)
- **Node version** (default: 20)
- **License** (default: MIT)

Display the parameters and confirm before proceeding.

## Step 3: Repository Layout

Create this structure in the current directory:

```
.
├── .claude/
│   └── CLAUDE.md
├── .github/
│   └── workflows/
│       └── ci.yml
├── .husky/
│   └── pre-commit
├── .vscode/
│   ├── extensions.json
│   └── settings.json
├── public/
├── src/
│   ├── App.tsx (or .vue/.ts depending on framework)
│   ├── App.test.tsx
│   ├── main.tsx
│   ├── vite-env.d.ts
│   └── styles/
│       └── index.css
├── .editorconfig
├── .gitignore
├── biome.json
├── CHANGELOG.md
├── index.html
├── LICENSE
├── Makefile
├── package.json
├── README.md
├── tsconfig.json
├── tsconfig.node.json
└── vite.config.ts
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
- `Add loading state to user profile component` (not just "fix bug")
- `Refactor authentication to use React Context` (not just "refactor")
- `Optimize bundle size by lazy loading routes` (not just "performance")

### What to Commit
- Always run `make format` and `make check` before committing
- Ensure all tests pass
- Ensure type checking passes
- Husky pre-commit hooks will enforce these automatically

## CHANGELOG.md Maintenance

### When to Update CHANGELOG.md
Update CHANGELOG.md for changes that affect users or developers of this project:

**Always update for:**
- New features or components
- Bug fixes
- Breaking changes (API changes, prop changes)
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
- User profile component with avatar support
- Dark mode toggle in settings

### Fixed
- Prevent form submission when validation fails
```

## Testing Requirements
- Write tests for new components and utilities
- Update tests when changing existing functionality
- Aim for >80% code coverage
- Run `make test` before committing

## Code Style
- Use TypeScript strict mode (enforced)
- Use functional components with hooks (React)
- Prefer const over let, avoid var
- Use async/await over promise chains
- Keep components focused and small (<200 lines)
- Extract business logic into custom hooks or utilities

## Review Before Committing
Before each commit, verify:
1. [ ] Code is formatted (`make format`)
2. [ ] Linting passes (`make lint`)
3. [ ] Type checking passes (`make type-check`)
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
indent_size = 2
trim_trailing_whitespace = true

[*.md]
trim_trailing_whitespace = false
```

### .gitignore
```
# Dependencies
node_modules/
.pnp
.pnp.js

# Build output
dist/
dist-ssr/
*.local

# Environment
.env
.env.local
.env.*.local

# Logs
logs/
*.log
npm-debug.log*
yarn-debug.log*
yarn-error.log*
pnpm-debug.log*

# Testing
coverage/

# Editor
.vscode/
.idea/
*.swp
*.swo
*~

# OS
.DS_Store
Thumbs.db

# Misc
.cache/
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
```markdown
# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Initial project setup with Vite + React + TypeScript
```

### README.md
```markdown
# {PROJECT_NAME}

A modern web application built with:

- **Vite** - Lightning-fast build tool
- **React** - UI library (or Vue/Vanilla based on selection)
- **TypeScript** - Type-safe JavaScript
- **Biome** - Fast linting and formatting
- **Vitest** - Unit testing framework
- **pnpm** - Fast, efficient package manager
- **Husky** - Git hooks for quality checks

## Prerequisites

- Node.js {NODE_VERSION}+
- pnpm (install: `npm install -g pnpm`)

## Quickstart

```bash
# Install dependencies
make install

# Start development server
make dev

# Run checks
make check
```

## Development

### Common Commands

```bash
make install     # Install dependencies
make dev         # Start dev server (http://localhost:5173)
make build       # Build for production
make preview     # Preview production build
make test        # Run tests
make test-watch  # Run tests in watch mode
make lint        # Run Biome linter
make format      # Format code with Biome
make type-check  # Type check with TypeScript
make check       # Run all checks (CI equivalent)
make help        # Show all available targets
```

### Project Structure

```
src/                # Source code
  components/       # React components
  hooks/            # Custom React hooks
  utils/            # Utility functions
  styles/           # Global styles
public/             # Static assets
.claude/            # Claude Code configuration
```

## Testing

```bash
# Run all tests
make test

# Run tests in watch mode
make test-watch

# Generate coverage report
make test-coverage
```

## Building for Production

```bash
# Build the project
make build

# Preview the build locally
make preview
```

The build output will be in the `dist/` directory.

## Working with Claude Code

This repository includes a `.claude/CLAUDE.md` file with project-specific instructions for Claude Code, including:
- Commit message guidelines
- When to update CHANGELOG.md
- Testing requirements
- Code style preferences

## License

{LICENSE_TYPE} - see LICENSE file for details
```

### package.json
Replace {PROJECT_NAME}, {PACKAGE_NAME}, and {NODE_VERSION}:
```json
{
  "name": "{PACKAGE_NAME}",
  "version": "0.1.0",
  "type": "module",
  "private": true,
  "description": "",
  "license": "MIT",
  "author": "Jonathan",
  "engines": {
    "node": ">={NODE_VERSION}"
  },
  "scripts": {
    "dev": "vite",
    "build": "tsc && vite build",
    "preview": "vite preview",
    "test": "vitest run",
    "test:watch": "vitest",
    "test:coverage": "vitest run --coverage",
    "lint": "biome check .",
    "format": "biome format --write .",
    "type-check": "tsc --noEmit",
    "check": "pnpm lint && pnpm type-check && pnpm test",
    "prepare": "husky"
  },
  "dependencies": {
    "react": "^18.3.1",
    "react-dom": "^18.3.1"
  },
  "devDependencies": {
    "@biomejs/biome": "^1.9.4",
    "@testing-library/react": "^16.0.1",
    "@testing-library/jest-dom": "^6.6.3",
    "@types/react": "^18.3.12",
    "@types/react-dom": "^18.3.1",
    "@vitejs/plugin-react": "^4.3.4",
    "@vitest/coverage-v8": "^2.1.8",
    "husky": "^9.1.7",
    "jsdom": "^25.0.1",
    "typescript": "^5.7.2",
    "vite": "^6.0.5",
    "vitest": "^2.1.8"
  }
}
```

### Makefile
```makefile
.PHONY: help install dev build preview test test-watch test-coverage lint format type-check check

help:
	@echo "Available targets:"
	@echo "  install     - Install dependencies"
	@echo "  dev         - Start dev server"
	@echo "  build       - Build for production"
	@echo "  preview     - Preview production build"
	@echo "  test        - Run tests"
	@echo "  test-watch  - Run tests in watch mode"
	@echo "  test-coverage - Run tests with coverage"
	@echo "  lint        - Run Biome linter"
	@echo "  format      - Format code with Biome"
	@echo "  type-check  - Type check with TypeScript"
	@echo "  check       - Run all checks (lint, type-check, test)"

install:
	pnpm install

dev:
	pnpm dev

build:
	pnpm build

preview:
	pnpm preview

test:
	pnpm test

test-watch:
	pnpm test:watch

test-coverage:
	pnpm test:coverage

lint:
	pnpm lint

format:
	pnpm format

type-check:
	pnpm type-check

check:
	pnpm check
```

### tsconfig.json
```json
{
  "compilerOptions": {
    "target": "ES2020",
    "lib": ["ES2020", "DOM", "DOM.Iterable"],
    "module": "ESNext",
    "skipLibCheck": true,

    /* Bundler mode */
    "moduleResolution": "bundler",
    "allowImportingTsExtensions": true,
    "resolveJsonModule": true,
    "isolatedModules": true,
    "noEmit": true,
    "jsx": "react-jsx",

    /* Linting */
    "strict": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "noFallthroughCasesInSwitch": true,
    "forceConsistentCasingInFileNames": true
  },
  "include": ["src"],
  "references": [{ "path": "./tsconfig.node.json" }]
}
```

### tsconfig.node.json
```json
{
  "compilerOptions": {
    "composite": true,
    "skipLibCheck": true,
    "module": "ESNext",
    "moduleResolution": "bundler",
    "allowSyntheticDefaultImports": true,
    "strict": true,
    "noEmit": true
  },
  "include": ["vite.config.ts"]
}
```

### vite.config.ts
```typescript
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  plugins: [react()],
  test: {
    globals: true,
    environment: 'jsdom',
    setupFiles: './src/test/setup.ts',
    coverage: {
      provider: 'v8',
      reporter: ['text', 'json', 'html'],
      exclude: [
        'node_modules/',
        'src/test/',
        '**/*.test.{ts,tsx}',
        '**/*.config.{ts,js}',
        'dist/'
      ]
    }
  }
})
```

### biome.json
```json
{
  "$schema": "https://biomejs.dev/schemas/1.9.4/schema.json",
  "organizeImports": {
    "enabled": true
  },
  "linter": {
    "enabled": true,
    "rules": {
      "recommended": true,
      "complexity": {
        "noForEach": "off"
      },
      "style": {
        "noNonNullAssertion": "off"
      }
    }
  },
  "formatter": {
    "enabled": true,
    "indentStyle": "space",
    "indentWidth": 2,
    "lineWidth": 100
  },
  "javascript": {
    "formatter": {
      "semicolons": "asNeeded",
      "quoteStyle": "single",
      "trailingCommas": "es5"
    }
  }
}
```

### index.html
```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <link rel="icon" type="image/svg+xml" href="/vite.svg" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>{PROJECT_NAME}</title>
  </head>
  <body>
    <div id="root"></div>
    <script type="module" src="/src/main.tsx"></script>
  </body>
</html>
```

### src/main.tsx
```typescript
import React from 'react'
import ReactDOM from 'react-dom/client'
import App from './App'
import './styles/index.css'

ReactDOM.createRoot(document.getElementById('root')!).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>,
)
```

### src/App.tsx
```typescript
import { useState } from 'react'

function App() {
  const [count, setCount] = useState(0)

  return (
    <div className="app">
      <h1>{PROJECT_NAME}</h1>
      <div className="card">
        <button onClick={() => setCount((count) => count + 1)}>
          count is {count}
        </button>
      </div>
    </div>
  )
}

export default App
```

### src/App.test.tsx
```typescript
import { render, screen, fireEvent } from '@testing-library/react'
import { describe, it, expect } from 'vitest'
import App from './App'

describe('App', () => {
  it('renders heading', () => {
    render(<App />)
    expect(screen.getByRole('heading')).toBeInTheDocument()
  })

  it('increments counter on button click', () => {
    render(<App />)
    const button = screen.getByRole('button')

    expect(button).toHaveTextContent('count is 0')

    fireEvent.click(button)
    expect(button).toHaveTextContent('count is 1')
  })
})
```

### src/vite-env.d.ts
```typescript
/// <reference types="vite/client" />
```

### src/test/setup.ts
```typescript
import '@testing-library/jest-dom'
```

### src/styles/index.css
```css
:root {
  font-family: Inter, system-ui, Avenir, Helvetica, Arial, sans-serif;
  line-height: 1.5;
  font-weight: 400;

  color-scheme: light dark;
  color: rgba(255, 255, 255, 0.87);
  background-color: #242424;

  font-synthesis: none;
  text-rendering: optimizeLegibility;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

body {
  margin: 0;
  display: flex;
  place-items: center;
  min-width: 320px;
  min-height: 100vh;
}

#root {
  max-width: 1280px;
  margin: 0 auto;
  padding: 2rem;
  text-align: center;
}

.app {
  padding: 2rem;
}

button {
  border-radius: 8px;
  border: 1px solid transparent;
  padding: 0.6em 1.2em;
  font-size: 1em;
  font-weight: 500;
  font-family: inherit;
  background-color: #1a1a1a;
  cursor: pointer;
  transition: border-color 0.25s;
}

button:hover {
  border-color: #646cff;
}

button:focus,
button:focus-visible {
  outline: 4px auto -webkit-focus-ring-color;
}

@media (prefers-color-scheme: light) {
  :root {
    color: #213547;
    background-color: #ffffff;
  }

  button {
    background-color: #f9f9f9;
  }
}
```

### .husky/pre-commit
```bash
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

pnpm check
```

### .vscode/settings.json
```json
{
  "editor.defaultFormatter": "biomejs.biome",
  "editor.formatOnSave": true,
  "editor.codeActionsOnSave": {
    "quickfix.biome": "explicit",
    "source.organizeImports.biome": "explicit"
  }
}
```

### .vscode/extensions.json
```json
{
  "recommendations": [
    "biomejs.biome"
  ]
}
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

      - uses: pnpm/action-setup@v4
        with:
          version: 9

      - uses: actions/setup-node@v4
        with:
          node-version: {NODE_VERSION}
          cache: 'pnpm'

      - name: Install dependencies
        run: pnpm install --frozen-lockfile

      - name: Run checks
        run: pnpm check

      - name: Build
        run: pnpm build
```

## Step 5: Initialize Repository

Execute these commands:

1. Initialize git with main branch:
   ```bash
   git init -b main
   ```

2. Install dependencies:
   ```bash
   pnpm install
   ```

3. Initialize Husky:
   ```bash
   pnpm exec husky init
   ```

4. Create pre-commit hook:
   ```bash
   echo "pnpm check" > .husky/pre-commit
   chmod +x .husky/pre-commit
   ```

## Step 6: Verification

Run the full check suite to ensure everything works:

```bash
make check
```

This runs:
- ✓ Linting (Biome)
- ✓ Type checking (TypeScript)
- ✓ Tests (Vitest)

Also verify the dev server starts:
```bash
make dev
```

Should start at http://localhost:5173

All checks must pass before proceeding.

## Step 7: Initial Commit

Create the initial commit:
```bash
git add .
git commit -m "Initial project setup

- Configure Vite + React + TypeScript
- Set up Biome for linting and formatting
- Add Vitest for testing
- Configure Husky for git hooks
- Include GitHub Actions CI"
```

## Step 8: Success Summary

Display:
- ✓ Repository initialized successfully
- File tree created
- Commands that were run
- Next steps:
  - Review `.claude/CLAUDE.md` for project-specific Claude Code guidelines
  - `make dev` - Start development server
  - `make test-watch` - Run tests in watch mode
  - `make check` - Run all checks
  - `make help` - See all available commands
  - Start building in `src/`

Note: The `.claude/CLAUDE.md` file contains instructions for Claude Code about:
- Making small, focused commits with descriptive messages
- Updating CHANGELOG.md for user-facing changes
- Running checks before committing

## Implementation Notes

- Replace all placeholders: {PROJECT_NAME}, {PACKAGE_NAME}, {NODE_VERSION}, {YEAR}, {LICENSE_TYPE}
- Use the current year (2026) for the license
- Validate that the package name is a valid npm package name (lowercase, hyphens allowed)
- If any step fails, stop and display a clear error message
- Show progress as you work through each step
- For Vue or Vanilla variants, adjust src/ files accordingly:
  - Vue: Use .vue files, @vitejs/plugin-vue
  - Vanilla: Use .ts files, no framework plugin
