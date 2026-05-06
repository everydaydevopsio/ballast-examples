# TypeScript Sample

This directory is a test case for [Ballast](https://github.com/everydaydevopsio/ballast)'s TypeScript language detection and rule installation.

## Purpose

This sample demonstrates how Ballast automatically detects a TypeScript project (via `package.json` with TypeScript dependencies or `tsconfig.json`) and installs appropriate agent rules for TypeScript development.

## What This Tests

- Automatic TypeScript language detection
- Installation of TypeScript-specific linting rules
- Rule file generation for TypeScript projects

## Running Ballast on This Sample

From this directory:

```bash
ballast install --target cursor --agent linting --yes
```

This will generate `.cursor/rules/typescript-linting.mdc` with TypeScript-specific linting guidance.

## Contents

- `package.json` — Node.js project manifest (triggers TypeScript detection)
- `tsconfig.json` — TypeScript configuration
- `src/` — Sample TypeScript source directory
