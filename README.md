# ballast-examples

[![Smoke Tests](https://github.com/everydaydevopsio/ballast-examples/actions/workflows/smoke.yml/badge.svg)](https://github.com/everydaydevopsio/ballast-examples/actions/workflows/smoke.yml)

Sample repositories for smoke testing Ballast language detection and install flows.

## Layout

- `go-sample/`
- `python-sample/`
- `typescript-sample/`

## CI Smoke Matrix

GitHub Actions runs smoke tests on push/PR for all three samples.

Workflow file: `.github/workflows/smoke.yml`

Each matrix job:

- builds `ballast` wrapper + language CLIs from source
- runs `ballast install --target cursor --agent linting --yes`
- verifies generated rule + language-specific config file

## Quick Smoke Test (Local)

From this folder, run:

```bash
for dir in go-sample python-sample typescript-sample; do
  echo "==> $dir"
  (cd "$dir" && ballast install --target cursor --agent linting --yes)
done
```

## Container Smoke Test

If your Ballast repo is next to this one:

```bash
cd ../ballast
docker build -f Dockerfile.smoke -t ballast-smoke .
docker run --rm -it -v "$(pwd)/../ballast-examples:/workspace/examples" ballast-smoke bash
```

Inside the container:

```bash
cd /workspace/examples
for dir in go-sample python-sample typescript-sample; do
  echo "==> $dir"
  (cd "$dir" && ballast install --target cursor --agent linting --yes)
done
```

Expected output:

- Each sample gets `.cursor/rules/linting.mdc`.
- Config files are language-specific (`.rulesrc.go.json`, `.rulesrc.python.json`, `.rulesrc.ts.json`).
