# ballast-examples

[![Smoke Tests](https://github.com/everydaydevopsio/ballast-examples/actions/workflows/smoke.yml/badge.svg)](https://github.com/everydaydevopsio/ballast-examples/actions/workflows/smoke.yml)

Sample repositories for smoke testing Ballast language detection and install flows.

## Layout

- `go-sample/`
- `python-sample/`
- `typescript-sample/`

## Run Smoke Tests

### 1) Run locally (host)

From repo root:

```bash
./smoke.sh
```

This runs:

- `ballast install --target cursor --agent linting --yes` in each sample project

Prerequisite: `ballast` must be available on your PATH.

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

The workflow runs automatically on push/PR. To trigger manually:

```bash
gh workflow run smoke.yml
```

## CI Smoke Matrix

GitHub Actions runs smoke tests on push/PR for all three samples.

Workflow file: `.github/workflows/smoke.yml`

Each matrix job:

- builds `ballast` wrapper + language CLIs from source
- runs `ballast install --target cursor --agent linting --yes`
- verifies generated rule file

## Expected Output

- Each sample gets `.cursor/rules/linting.mdc`.
