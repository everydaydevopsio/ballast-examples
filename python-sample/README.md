# Python Sample

This directory is a test case for [Ballast](https://github.com/everydaydevopsio/ballast)'s Python language detection and rule installation.

## Purpose

This sample demonstrates how Ballast automatically detects a Python project (via `pyproject.toml` or `requirements.txt`) and installs appropriate agent rules for Python development.

## What This Tests

- Automatic Python language detection
- Installation of Python-specific linting rules
- Rule file generation for Python projects

## Running Ballast on This Sample

From this directory:

```bash
ballast install --target cursor --agent linting --yes
```

This will generate `.cursor/rules/python-linting.mdc` with Python-specific linting guidance.

## Contents

- `pyproject.toml` — Python project configuration (triggers Python language detection)
- `app.py` — Minimal Python application
