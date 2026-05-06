# Go Sample

This directory is a test case for [Ballast](https://github.com/everydaydevopsio/ballast)'s Go language detection and rule installation.

## Purpose

This sample demonstrates how Ballast automatically detects a Go project (via `go.mod`) and installs appropriate agent rules for Go development.

## What This Tests

- Automatic Go language detection
- Installation of Go-specific linting rules
- Rule file generation for Go projects

## Running Ballast on This Sample

From this directory:

```bash
ballast install --target cursor --agent linting --yes
```

This will generate `.cursor/rules/go-linting.mdc` with Go-specific linting guidance.

## Contents

- `go.mod` — Go module definition (triggers Go language detection)
- `main.go` — Minimal Go application
- `AGENTS.md` — Agent configuration for this sample
