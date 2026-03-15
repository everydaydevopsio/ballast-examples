#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT"

if [ ! -d .git ]; then
  git init
fi

if ! git symbolic-ref --quiet --short HEAD >/dev/null; then
  git checkout -b main
else
  current_branch="$(git symbolic-ref --short HEAD)"
  if [ "$current_branch" != "main" ]; then
    git branch -M main
  fi
fi

git add .
if ! git diff --cached --quiet; then
  git commit -m "chore: add ballast smoke test examples"
fi

echo "Repository initialized on branch: $(git branch --show-current)"
echo "Next: git remote add origin <your-repo-url> && git push -u origin main"
