#!/usr/bin/env python3
from pathlib import Path
import shutil

root = Path(__file__).resolve().parents[1]
version = (root / "VERSION").read_text(encoding="utf-8").strip()
source = root / "book" / f"book-v{version}.md"
pdf = root / "book" / f"book-v{version}.pdf"

if not source.exists():
    raise SystemExit(f"缺少 Markdown：{source}")
if not pdf.exists():
    print(f"⚠️  跳过 PDF（暂不存在）：{pdf.name}")

docs = root / "docs"
assets_out = docs / "assets"
downloads = docs / "downloads"
assets_out.mkdir(parents=True, exist_ok=True)
downloads.mkdir(parents=True, exist_ok=True)

for path in (root / "assets").rglob("*"):
    if path.is_file() and path.name != ".gitkeep":
        rel = path.relative_to(root / "assets")
        target = assets_out / rel
        target.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(path, target)

text = source.read_text(encoding="utf-8")
text = text.replace("../assets/", "assets/")
front_matter = "---\nlayout: default\ntitle: Codex 橙皮书\n---\n\n"
(docs / "book.md").write_text(front_matter + text, encoding="utf-8")
if pdf.exists():
    shutil.copy2(pdf, downloads / pdf.name)
shutil.copy2(source, downloads / source.name)
print("Pages source prepared")
