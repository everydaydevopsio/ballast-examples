# ballast-examples

Sample repositories for smoke testing Ballast language detection and install flows.

## Layout

- `go-sample/`
- `python-sample/`
- `typescript-sample/`

## Quick Smoke Test

From this folder, run:

```bash
# Test local binaries on host
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
