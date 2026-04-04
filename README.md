# ballast-examples

Sample repositories for smoke testing Ballast language detection and install flows.

TypeScript, Python, Go, Ansible, and Terraform all participate in wrapper auto-detection now.

## Ballast

- Repository: https://github.com/everydaydevopsio/ballast
- Installation guide: https://github.com/everydaydevopsio/ballast/blob/main/docs/installation.md

Quick install (wrapper CLI):

```bash
go install github.com/everydaydevopsio/ballast/cli/ballast@latest
```

For these example smoke tests, the `ballast` wrapper command must resolve on your PATH. If you only have the backend installed locally, add an alias such as `alias ballast=ballast-go`, or run `ballast-go install --language <lang> ...` directly instead of wrapper auto-detection.

## Layout

- `go-sample/`
- `python-sample/`
- `typescript-sample/`
- `ansible-sample/`
  Includes both `hosts.ini` and `hosts.ini.example` so the fixture is runnable without renaming files.
- `terraform-sample/`
  Includes `.terraform-version`, `versions.tf`, `providers.tf`, and `main.tf` so the fixture exercises Terraform root detection and version pinning.

## Run Smoke Tests

### 1. Run locally (host)

From repo root:

```bash
./smoke.sh
```

This runs:

- `ballast install --target cursor --agent linting --yes` in `go-sample/`, `python-sample/`, `typescript-sample/`, `ansible-sample/`, and `terraform-sample/`

Prerequisite: `ballast` must resolve on your PATH.

### 2. Run in Docker (preinstalled CLIs)

If your Ballast repo is next to this one:

```bash
cd ../ballast
docker build -f Dockerfile.smoke -t ballast-smoke .
docker run --rm -it -v "$(pwd)/../ballast-examples:/workspace/examples" ballast-smoke bash -lc "cd /workspace/examples && ./smoke.sh"
```

### 3. Run in Docker (lazy-download CLIs)

```bash
cd ../ballast
docker build -f Dockerfile.smoke --build-arg PREINSTALL_ALL_BINARIES=0 -t ballast-smoke-lazy .
docker run --rm -it -v "$(pwd)/../ballast-examples:/workspace/examples" ballast-smoke-lazy bash -lc "cd /workspace/examples && ./smoke.sh"
```

### 4. Run in GitHub Actions

Smoke tests run from the `ballast` repository workflow. To trigger manually:

```bash
gh workflow run examples-smoke.yml --repo everydaydevopsio/ballast
```

## CI Smoke Matrix

GitHub Actions runs smoke tests on push/PR in `ballast` for all five samples.

Workflow file: `ballast/.github/workflows/examples-smoke.yml`

Each matrix job:

- builds `ballast` wrapper + language CLIs from source
- runs `ballast install --target cursor --agent linting --yes`
- verifies generated rule file

## Expected Output

- `go-sample/` gets `.cursor/rules/go-linting.mdc`
- `python-sample/` gets `.cursor/rules/python-linting.mdc`
- `typescript-sample/` gets `.cursor/rules/typescript-linting.mdc`
- `ansible-sample/` gets `.cursor/rules/ansible-linting.mdc`
- `terraform-sample/` gets `.cursor/rules/terraform-linting.mdc`
