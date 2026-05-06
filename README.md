# ballast-examples

Sample repositories for smoke testing [Ballast](https://github.com/everydaydevopsio/ballast) language detection and rule installation flows.

This repository contains minimal project samples in various languages and frameworks to test how Ballast:
- Auto-detects project languages and frameworks
- Installs language-specific agent rules
- Generates configuration for AI editors (Cursor, Codeium)

## Language Support

- **TypeScript, Python, and Go** — Automatic language detection via wrapper
- **Ansible** — Explicit language specification via `ballast-go install --language ansible`
- **Terraform** — Automatic IaC language detection

## Ballast

- Repository: https://github.com/everydaydevopsio/ballast
- Installation guide: https://github.com/everydaydevopsio/ballast/blob/main/docs/installation.md

Quick install (Go CLI):

```bash
go install github.com/everydaydevopsio/ballast/packages/ballast-go/cmd/ballast-go@latest
```

If you only have `ballast-go` installed and want the `ballast` command name locally, add an alias (for example in your shell profile):

```bash
alias ballast=ballast-go
```

## Sample Directories

Each sample is a minimal project that demonstrates Ballast's language detection and rule installation:

- **`go-sample/`** — Go application with automatic language detection
- **`python-sample/`** — Python application with automatic language detection
- **`typescript-sample/`** — TypeScript/Node.js application with automatic language detection
- **`terraform-sample/`** — Terraform infrastructure code with automatic IaC detection
- **`ansible-sample/`** — Ansible playbooks and roles (requires explicit `--language ansible`)
- **`empty-sample/`** — Empty directory for testing Ballast initialization before code exists

See individual README.md files in each sample for details.

## Run Smoke Tests

### 1) Run locally (host)

From repo root:

```bash
./smoke.sh
```

This runs:

- `ballast install --target cursor --agent linting --yes` in `go-sample/`, `python-sample/`, `typescript-sample/`, and `terraform-sample/`
- `ballast-go install --language ansible --target cursor --agent linting --yes` in `ansible-sample/`
- `ballast install --target cursor --agent linting --yes` in `empty-sample/` (tests initialization without existing code)

Prerequisite: `ballast` must resolve on your PATH for auto-detected samples, and `ballast-go` must also be available for the Ansible sample.

### 2) Run in Docker (preinstalled CLIs)

If your Ballast repo is next to this one:

```bash
cd ../ballast
docker build -f Dockerfile.smoke -t ballast-smoke .
docker run --rm -it -v "$(pwd)/../ballast-examples:/workspace/examples" ballast-smoke bash -lc "cd /workspace/examples && ./smoke.sh"
```

### 3) Run in Docker (lazy-download CLIs)

```bash
cd ../ballast
docker build -f Dockerfile.smoke --build-arg PREINSTALL_ALL_BINARIES=0 -t ballast-smoke-lazy .
docker run --rm -it -v "$(pwd)/../ballast-examples:/workspace/examples" ballast-smoke-lazy bash -lc "cd /workspace/examples && ./smoke.sh"
```

### 4) Run in GitHub Actions

Smoke tests run from the `ballast` repository workflow. To trigger manually:

```bash
gh workflow run examples-smoke.yml --repo everydaydevopsio/ballast
```

## CI Smoke Matrix

GitHub Actions runs smoke tests on push/PR in `ballast` for all samples.

Workflow file: `ballast/.github/workflows/examples-smoke.yml`

Each matrix job:

- builds `ballast` wrapper + language CLIs from source
- runs `ballast install --target cursor --agent linting --yes` for Go/Python/TypeScript/Terraform/empty samples
- runs `ballast-go install --language ansible --target cursor --agent linting --yes` for Ansible
- verifies generated rule files in `.cursor/rules/`

## Expected Output

When Ballast runs successfully on each sample, it generates rule files:

- `go-sample/` → `.cursor/rules/go-linting.mdc`
- `python-sample/` → `.cursor/rules/python-linting.mdc`
- `typescript-sample/` → `.cursor/rules/typescript-linting.mdc`
- `terraform-sample/` → `.cursor/rules/terraform-linting.mdc`
- `ansible-sample/` → `.cursor/rules/ansible-linting.mdc`
- `empty-sample/` → `.cursor/rules/` (tests baseline rule installation)
