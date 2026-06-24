#!/usr/bin/env bash
set -euo pipefail

VERSION="$(tr -d '[:space:]' < VERSION)"
PDF_SOURCE="${1:-}"
MD_SOURCE="${2:-}"

if [[ -z "$PDF_SOURCE" || -z "$MD_SOURCE" ]]; then
  echo "用法：scripts/import_book.sh /path/book.pdf /path/book.md"
  exit 1
fi

cp "$PDF_SOURCE" "book/book-v${VERSION}.pdf"
cp "$MD_SOURCE" "book/book-v${VERSION}.md"

# 书稿中的图片路径应指向仓库根目录 assets，例如 ../assets/fig.png
(
  cd book
  sha256sum "book-v${VERSION}.pdf" "book-v${VERSION}.md" > SHA256SUMS.txt
)

python3 scripts/validate.py
