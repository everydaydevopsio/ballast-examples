# Ansible Sample

This directory is a test case for [Ballast](https://github.com/everydaydevopsio/ballast)'s Ansible language support through explicit language specification.

## Purpose

This sample demonstrates how Ballast installs agent rules for Ansible projects using the `--language ansible` flag, since Ansible projects don't have a single definitive marker file for automatic detection.

## What This Tests

- Explicit Ansible language specification via `--language ansible`
- Installation of Ansible-specific linting rules
- Rule file generation for Ansible playbooks and roles

## Running Ballast on This Sample

From this directory:

```bash
ballast-go install --language ansible --target cursor --agent linting --yes
```

This will generate `.cursor/rules/ansible-linting.mdc` with Ansible-specific linting guidance.

## Contents

- `ansible.cfg` — Ansible configuration
- `hosts.ini` / `hosts.ini.example` — Inventory files (both included so fixture is runnable without renaming)
- `playbook.yml` — Sample Ansible playbook
- `requirements.yml` — Ansible role/collection requirements

## Note

This sample uses `ballast-go` directly rather than the auto-detected `ballast` wrapper, since Ansible detection requires explicit language specification.
