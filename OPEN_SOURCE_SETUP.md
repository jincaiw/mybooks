# 首次启用说明

## 1. 导入书稿

把 PDF、Markdown 和插图准备好后执行：

```bash
scripts/import_book.sh /path/to/book.pdf /path/to/book.md
cp /path/to/images/* assets/
python3 scripts/validate.py
```

Markdown 图片路径使用：

```markdown
![图示](../assets/figure.png)
```

## 2. 发布仓库

```bash
scripts/publish.sh
```

## 3. 启用 GitHub Pages

进入仓库：

```text
Settings → Pages → Build and deployment → Source: GitHub Actions
```

随后手工运行或重新运行 `Deploy GitHub Pages` 工作流。

## 4. 建议开启

- Settings → General → Issues
- Settings → General → Discussions
- Settings → Code security → Private vulnerability reporting
- Settings → Branches / Rulesets → 保护 main
- Require pull request before merging
- Require status check: Validate Book
- Block force pushes
- Require linear history（可选）
