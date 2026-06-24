#!/usr/bin/env python3
from pathlib import Path
import hashlib
import re
import sys

allow_missing = "--allow-missing" in sys.argv
root = Path(__file__).resolve().parents[1]
errors = []
version = (root / "VERSION").read_text(encoding="utf-8").strip()
md = root / "book" / f"book-v{version}.md"
pdf = root / "book" / f"book-v{version}.pdf"
checksums = root / "book" / "SHA256SUMS.txt"

for path in (md, pdf):
    if not path.exists():
        if allow_missing:
            print(f"⚠️  跳过缺失文件：{path.relative_to(root)}")
        else:
            errors.append(f"缺少文件：{path.relative_to(root)}")

if md.exists():
    text = md.read_text(encoding="utf-8")
    if version not in text:
        errors.append("Markdown 中未找到 VERSION 对应版本号")
    for target in re.findall(r"!\[[^\]]*\]\(([^)]+)\)", text):
        target = target.split()[0].strip("<>")
        if target.startswith(("http://", "https://", "data:")):
            continue
        candidate = (md.parent / target).resolve()
        if not candidate.exists():
            errors.append(f"图片引用不存在：{target}")

if pdf.exists():
    with pdf.open("rb") as handle:
        if handle.read(5) != b"%PDF-":
            errors.append("PDF 文件头无效")

if md.exists() and pdf.exists():
    expected = []
    for path in (pdf, md):
        digest = hashlib.sha256(path.read_bytes()).hexdigest()
        expected.append(f"{digest}  {path.name}")
    current = checksums.read_text(encoding="utf-8").strip().splitlines() if checksums.exists() else []
    if current != expected:
        errors.append("SHA256SUMS.txt 与当前书稿不一致；请重新生成")

if errors:
    print("Validation failed:")
    for error in errors:
        print(f"- {error}")
    sys.exit(1)

print(f"Validation passed for v{version}")
