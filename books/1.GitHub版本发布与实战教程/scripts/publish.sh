#!/usr/bin/env bash
set -euo pipefail

OWNER="jincaiw"
REPO="mybook"
BOOK_DIR="$(basename "$(cd "$(dirname "$0")/.." && pwd)")"
VERSION="$(tr -d '[:space:]' < VERSION)"

command -v git >/dev/null || { echo "缺少 git"; exit 1; }
command -v gh >/dev/null || { echo "缺少 GitHub CLI，请先安装并执行 gh auth login"; exit 1; }

gh auth status
python3 scripts/validate.py

if [[ ! -d .git ]]; then
  git init -b main
fi

git add .
git commit -m "release: ${BOOK_DIR} v${VERSION}" || true

if gh repo view "$OWNER/$REPO" >/dev/null 2>&1; then
  git remote get-url origin >/dev/null 2>&1 || git remote add origin "https://github.com/$OWNER/$REPO.git"
else
  gh repo create "$OWNER/$REPO" --public \
    --description "MyBook - ${BOOK_DIR}" \
    --source . --remote origin
fi

git push -u origin main

TAG="${BOOK_DIR}-v${VERSION}"
if ! git rev-parse "${TAG}" >/dev/null 2>&1; then
  git tag -a "${TAG}" -m "${BOOK_DIR}: Release v${VERSION}"
fi
git push origin "${TAG}"

echo "Published: https://github.com/$OWNER/$REPO"
