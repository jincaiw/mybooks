#!/usr/bin/env bash
set -euo pipefail

OWNER="jincaiw"
REPO="mybook"
VERSION="$(tr -d '[:space:]' < VERSION)"

command -v git >/dev/null || { echo "缺少 git"; exit 1; }
command -v gh >/dev/null || { echo "缺少 GitHub CLI，请先安装并执行 gh auth login"; exit 1; }

gh auth status
python3 scripts/validate.py

if [[ ! -d .git ]]; then
  git init -b main
fi

git add .
git commit -m "release: publish book v${VERSION}" || true

if gh repo view "$OWNER/$REPO" >/dev/null 2>&1; then
  git remote get-url origin >/dev/null 2>&1 || git remote add origin "https://github.com/$OWNER/$REPO.git"
else
  gh repo create "$OWNER/$REPO" --public \
    --description "GitHub 版本发布与云原生 GitOps 实战教程" \
    --source . --remote origin
fi

git push -u origin main

if ! git rev-parse "v${VERSION}" >/dev/null 2>&1; then
  git tag -a "v${VERSION}" -m "Release v${VERSION}"
fi
git push origin "v${VERSION}"

echo "Published: https://github.com/$OWNER/$REPO"
