#!/usr/bin/env bash
set -euo pipefail

for dir in go-sample python-sample typescript-sample; do
  echo "==> $dir"
  (
    cd "$dir"
    ballast install --target cursor --agent linting --yes
  )
done

echo "==> ansible-sample"
(
  cd ansible-sample
  ballast-go install --language ansible --target cursor --agent linting --yes
)

echo "Smoke test complete."
