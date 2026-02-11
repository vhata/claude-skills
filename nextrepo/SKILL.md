---
name: nextrepo
description: create a modern Next.js project with best practices
---

Create a brand-new Next.js project with modern tooling (Next.js 15, TypeScript, Tailwind CSS, Biome, Vitest, pnpm) and sensible defaults.

## Step 1: Prerequisites Check

Before starting, verify all required tools are installed:

**git**: Run `git --version`
- If missing: "ERROR: git not installed. Install from: https://git-scm.com/downloads"

**node**: Run `node --version` (require 18.18+)
- If missing/old: "ERROR: Node.js 18.18+ required. Install from: https://nodejs.org/"

**pnpm**: Run `pnpm --version`
- If missing: "ERROR: pnpm not installed. Install with: npm install -g pnpm"

If all prerequisites are met, display: "✓ All prerequisites found. Proceeding with setup..."

## Step 2: Gather Project Parameters

Ask the user for:
- **Project name** (e.g., "my-awesome-app")
- **Package name** (default: kebab-case version of project name)
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
│   ├── app/
│   │   ├── api/
│   │   │   └── health/
│   │   │       └── route.ts
│   │   ├── globals.css
│   │   ├── layout.tsx
│   │   └── page.tsx
│   ├── components/
│   │   └── Counter.tsx
│   ├── lib/
│   │   └── utils.ts
│   └── __tests__/
│       ├── setup.ts
│       └── components/
│           └── Counter.test.tsx
├── .editorconfig
├── .env.example
├── .gitignore
├── biome.json
├── CHANGELOG.md
├── LICENSE
├── next.config.ts
├── package.json
├── postcss.config.mjs
├── README.md
├── tailwind.config.ts
├── tsconfig.json
└── vitest.config.ts
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
- `Add user authentication with NextAuth.js` (not just "add auth")
- `Optimize image loading with Next.js Image component` (not just "fix images")
- `Implement server-side data fetching for blog posts` (not just "add blog")

### What to Commit
- Always run `pnpm format` and `pnpm check` before committing
- Ensure all tests pass
- Ensure type checking passes
- Ensure the build succeeds
- Husky pre-commit hooks will enforce these automatically

## CHANGELOG.md Maintenance

### When to Update CHANGELOG.md
Update CHANGELOG.md for changes that affect users or developers of this project:

**Always update for:**
- New features or pages
- API route changes
- Bug fixes
- Breaking changes
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
- User profile page with SSR
- API endpoint for user data fetching

### Fixed
- Fix hydration mismatch in navigation component
```

## Next.js Best Practices

### Server vs Client Components
- **Default to Server Components** - Better performance, smaller bundles
- Use `'use client'` only when needed:
  - Component uses hooks (useState, useEffect, etc.)
  - Component uses browser APIs
  - Component needs event handlers

### File Organization
- **app/** - App Router pages and layouts
- **app/api/** - API routes
- **components/** - Reusable UI components
- **lib/** - Utility functions, helpers, types
- **public/** - Static assets

### Data Fetching
- Prefer Server Components with async/await
- Use fetch with Next.js caching: `fetch(url, { cache: 'force-cache' })`
- Use Server Actions for mutations
- Keep client-side fetching minimal

## Testing Requirements
- Write tests for components and utilities
- Test both server and client components appropriately
- Aim for >80% code coverage
- Run `pnpm test` before committing

## Code Style
- Use TypeScript strict mode (enforced)
- Prefer Server Components over Client Components
- Use Tailwind CSS for styling
- Keep components focused and small (<200 lines)
- Extract business logic into lib/ utilities

## Review Before Committing
Before each commit, verify:
1. [ ] Code is formatted (`pnpm format`)
2. [ ] Linting passes (`pnpm lint`)
3. [ ] Type checking passes (`pnpm type-check`)
4. [ ] Tests pass (`pnpm test`)
5. [ ] Build succeeds (`pnpm build`)
6. [ ] CHANGELOG.md updated if appropriate
7. [ ] Commit message is descriptive
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
.next/
out/
dist/
build/

# Environment
.env
.env*.local

# Logs
logs/
*.log
npm-debug.log*
yarn-debug.log*
yarn-error.log*
pnpm-debug.log*

# Testing
coverage/
.nyc_output

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
.turbo/
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
- Initial project setup with Next.js 15 + TypeScript + Tailwind CSS
```

### README.md
```markdown
# {PROJECT_NAME}

A modern full-stack web application built with:

- **Next.js 15** - React framework with App Router
- **TypeScript** - Type-safe JavaScript
- **Tailwind CSS** - Utility-first CSS framework
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
pnpm install

# Start development server
pnpm dev

# Run checks
pnpm check
```

Open [http://localhost:3000](http://localhost:3000) in your browser.

## Development

### Common Commands

```bash
pnpm dev           # Start dev server (http://localhost:3000)
pnpm build         # Build for production
pnpm start         # Start production server
pnpm test          # Run tests
pnpm test:watch    # Run tests in watch mode
pnpm lint          # Run Biome linter
pnpm format        # Format code with Biome
pnpm type-check    # Type check with TypeScript
pnpm check         # Run all checks (CI equivalent)
```

### Project Structure

```
src/
  app/              # Next.js App Router pages and layouts
    api/            # API routes
  components/       # React components
  lib/              # Utilities, types, helpers
  __tests__/        # Test files
public/             # Static assets
.claude/            # Claude Code configuration
```

## Server vs Client Components

Next.js 15 uses Server Components by default:

- **Server Components** (default): Better performance, no JavaScript sent to client
- **Client Components**: Use `'use client'` directive for interactivity, hooks, browser APIs

## Testing

```bash
# Run all tests
pnpm test

# Run tests in watch mode
pnpm test:watch

# Generate coverage report
pnpm test:coverage
```

## Building for Production

```bash
# Build the project
pnpm build

# Run the production build locally
pnpm start
```

## Environment Variables

Copy `.env.example` to `.env.local` and configure:

```bash
cp .env.example .env.local
```

## Working with Claude Code

This repository includes a `.claude/CLAUDE.md` file with project-specific instructions for Claude Code, including:
- Commit message guidelines
- When to update CHANGELOG.md
- Next.js best practices (Server vs Client Components)
- Testing requirements

## Learn More

- [Next.js Documentation](https://nextjs.org/docs)
- [Tailwind CSS Documentation](https://tailwindcss.com/docs)

## License

{LICENSE_TYPE} - see LICENSE file for details
```

### package.json
Replace {PROJECT_NAME}, {PACKAGE_NAME}, and {NODE_VERSION}:
```json
{
  "name": "{PACKAGE_NAME}",
  "version": "0.1.0",
  "private": true,
  "description": "",
  "license": "MIT",
  "author": "Jonathan",
  "engines": {
    "node": ">={NODE_VERSION}"
  },
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start",
    "test": "vitest run",
    "test:watch": "vitest",
    "test:coverage": "vitest run --coverage",
    "lint": "biome check .",
    "format": "biome format --write .",
    "type-check": "tsc --noEmit",
    "check": "pnpm lint && pnpm type-check && pnpm test && pnpm build",
    "prepare": "husky"
  },
  "dependencies": {
    "next": "^15.1.4",
    "react": "^19.0.0",
    "react-dom": "^19.0.0"
  },
  "devDependencies": {
    "@biomejs/biome": "^1.9.4",
    "@testing-library/react": "^16.0.1",
    "@testing-library/jest-dom": "^6.6.3",
    "@types/node": "^22.10.2",
    "@types/react": "^19.0.1",
    "@types/react-dom": "^19.0.2",
    "@vitejs/plugin-react": "^4.3.4",
    "@vitest/coverage-v8": "^2.1.8",
    "autoprefixer": "^10.4.20",
    "husky": "^9.1.7",
    "jsdom": "^25.0.1",
    "postcss": "^8.4.49",
    "tailwindcss": "^3.4.17",
    "typescript": "^5.7.2",
    "vitest": "^2.1.8"
  }
}
```

### tsconfig.json
```json
{
  "compilerOptions": {
    "target": "ES2020",
    "lib": ["dom", "dom.iterable", "esnext"],
    "allowJs": true,
    "skipLibCheck": true,
    "strict": true,
    "noEmit": true,
    "esModuleInterop": true,
    "module": "esnext",
    "moduleResolution": "bundler",
    "resolveJsonModule": true,
    "isolatedModules": true,
    "jsx": "preserve",
    "incremental": true,
    "plugins": [
      {
        "name": "next"
      }
    ],
    "paths": {
      "@/*": ["./src/*"]
    }
  },
  "include": ["next-env.d.ts", "**/*.ts", "**/*.tsx", ".next/types/**/*.ts"],
  "exclude": ["node_modules"]
}
```

### next.config.ts
```typescript
import type { NextConfig } from 'next'

const nextConfig: NextConfig = {
  /* config options here */
}

export default nextConfig
```

### tailwind.config.ts
```typescript
import type { Config } from 'tailwindcss'

const config: Config = {
  content: [
    './src/pages/**/*.{js,ts,jsx,tsx,mdx}',
    './src/components/**/*.{js,ts,jsx,tsx,mdx}',
    './src/app/**/*.{js,ts,jsx,tsx,mdx}',
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}

export default config
```

### postcss.config.mjs
```javascript
/** @type {import('postcss-load-config').Config} */
const config = {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
  },
}

export default config
```

### vitest.config.ts
```typescript
import react from '@vitejs/plugin-react'
import { resolve } from 'node:path'
import { defineConfig } from 'vitest/config'

export default defineConfig({
  plugins: [react()],
  test: {
    globals: true,
    environment: 'jsdom',
    setupFiles: './src/__tests__/setup.ts',
    coverage: {
      provider: 'v8',
      reporter: ['text', 'json', 'html'],
      exclude: [
        'node_modules/',
        'src/__tests__/',
        '**/*.test.{ts,tsx}',
        '**/*.config.{ts,js,mjs}',
        '.next/',
        'dist/',
      ],
    },
  },
  resolve: {
    alias: {
      '@': resolve(__dirname, './src'),
    },
  },
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

### .env.example
```
# Add your environment variables here
# Example:
# DATABASE_URL=
# NEXT_PUBLIC_API_URL=
```

### src/app/layout.tsx
```typescript
import type { Metadata } from 'next'
import './globals.css'

export const metadata: Metadata = {
  title: '{PROJECT_NAME}',
  description: 'Built with Next.js',
}

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode
}>) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  )
}
```

### src/app/page.tsx
```typescript
import Counter from '@/components/Counter'

export default function Home() {
  return (
    <main className="flex min-h-screen flex-col items-center justify-center p-24">
      <div className="max-w-5xl w-full space-y-8">
        <h1 className="text-4xl font-bold text-center">
          Welcome to {PROJECT_NAME}
        </h1>
        <p className="text-center text-gray-600">
          Built with Next.js 15, TypeScript, and Tailwind CSS
        </p>
        <div className="flex justify-center">
          <Counter />
        </div>
      </div>
    </main>
  )
}
```

### src/app/globals.css
```css
@tailwind base;
@tailwind components;
@tailwind utilities;

:root {
  --background: #ffffff;
  --foreground: #171717;
}

@media (prefers-color-scheme: dark) {
  :root {
    --background: #0a0a0a;
    --foreground: #ededed;
  }
}

body {
  color: var(--foreground);
  background: var(--background);
  font-family: Arial, Helvetica, sans-serif;
}
```

### src/app/api/health/route.ts
```typescript
import { NextResponse } from 'next/server'

export async function GET() {
  return NextResponse.json({ status: 'ok', timestamp: new Date().toISOString() })
}
```

### src/components/Counter.tsx
```typescript
'use client'

import { useState } from 'react'

export default function Counter() {
  const [count, setCount] = useState(0)

  return (
    <div className="flex flex-col items-center gap-4">
      <div className="text-2xl font-mono">{count}</div>
      <div className="flex gap-2">
        <button
          onClick={() => setCount((c) => c - 1)}
          className="px-4 py-2 bg-red-500 text-white rounded hover:bg-red-600 transition-colors"
        >
          Decrement
        </button>
        <button
          onClick={() => setCount(0)}
          className="px-4 py-2 bg-gray-500 text-white rounded hover:bg-gray-600 transition-colors"
        >
          Reset
        </button>
        <button
          onClick={() => setCount((c) => c + 1)}
          className="px-4 py-2 bg-blue-500 text-white rounded hover:bg-blue-600 transition-colors"
        >
          Increment
        </button>
      </div>
    </div>
  )
}
```

### src/lib/utils.ts
```typescript
/**
 * Example utility function
 */
export function formatDate(date: Date): string {
  return new Intl.DateTimeFormat('en-US', {
    year: 'numeric',
    month: 'long',
    day: 'numeric',
  }).format(date)
}
```

### src/__tests__/setup.ts
```typescript
import '@testing-library/jest-dom'
```

### src/__tests__/components/Counter.test.tsx
```typescript
import { render, screen, fireEvent } from '@testing-library/react'
import { describe, it, expect } from 'vitest'
import Counter from '@/components/Counter'

describe('Counter', () => {
  it('renders initial count of 0', () => {
    render(<Counter />)
    expect(screen.getByText('0')).toBeInTheDocument()
  })

  it('increments count when increment button is clicked', () => {
    render(<Counter />)
    const incrementButton = screen.getByText('Increment')

    fireEvent.click(incrementButton)
    expect(screen.getByText('1')).toBeInTheDocument()

    fireEvent.click(incrementButton)
    expect(screen.getByText('2')).toBeInTheDocument()
  })

  it('decrements count when decrement button is clicked', () => {
    render(<Counter />)
    const decrementButton = screen.getByText('Decrement')

    fireEvent.click(decrementButton)
    expect(screen.getByText('-1')).toBeInTheDocument()
  })

  it('resets count to 0 when reset button is clicked', () => {
    render(<Counter />)
    const incrementButton = screen.getByText('Increment')
    const resetButton = screen.getByText('Reset')

    fireEvent.click(incrementButton)
    fireEvent.click(incrementButton)
    expect(screen.getByText('2')).toBeInTheDocument()

    fireEvent.click(resetButton)
    expect(screen.getByText('0')).toBeInTheDocument()
  })
})
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
  },
  "tailwindCSS.experimental.classRegex": [
    ["cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]"],
    ["cn\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]"]
  ]
}
```

### .vscode/extensions.json
```json
{
  "recommendations": [
    "biomejs.biome",
    "bradlc.vscode-tailwindcss"
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
pnpm check
```

This runs:
- ✓ Linting (Biome)
- ✓ Type checking (TypeScript)
- ✓ Tests (Vitest)
- ✓ Build (Next.js)

Also verify the dev server starts:
```bash
pnpm dev
```

Should start at http://localhost:3000

All checks must pass before proceeding.

## Step 7: Initial Commit

Create the initial commit:
```bash
git add .
git commit -m "Initial project setup

- Configure Next.js 15 + TypeScript + Tailwind CSS
- Set up Biome for linting and formatting
- Add Vitest for testing
- Configure Husky for git hooks
- Include GitHub Actions CI
- Add example Counter component and health API route"
```

## Step 8: Success Summary

Display:
- ✓ Repository initialized successfully
- File tree created
- Commands that were run
- Next steps:
  - Review `.claude/CLAUDE.md` for project-specific Claude Code guidelines
  - `pnpm dev` - Start development server at http://localhost:3000
  - `pnpm test:watch` - Run tests in watch mode
  - `pnpm check` - Run all checks
  - Start building in `src/app/`

Note: The `.claude/CLAUDE.md` file contains instructions for Claude Code about:
- Making small, focused commits with descriptive messages
- Updating CHANGELOG.md for user-facing changes
- Next.js best practices (Server vs Client Components)
- Running checks before committing

## Implementation Notes

- Replace all placeholders: {PROJECT_NAME}, {PACKAGE_NAME}, {NODE_VERSION}, {YEAR}, {LICENSE_TYPE}
- Use the current year (2026) for the license
- Validate that the package name is a valid npm package name (lowercase, hyphens allowed)
- If any step fails, stop and display a clear error message
- Show progress as you work through each step
- Emphasize Server Components as the default, Client Components only when needed
