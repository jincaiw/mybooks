# GitHub 版本发布与云原生 GitOps 实战教程

[![Validate](https://github.com/jincaiw/mybook/actions/workflows/validate.yml/badge.svg)](https://github.com/jincaiw/mybook/actions/workflows/validate.yml)
[![Pages](https://github.com/jincaiw/mybook/actions/workflows/pages.yml/badge.svg)](https://github.com/jincaiw/mybook/actions/workflows/pages.yml)
[![Release](https://img.shields.io/github/v/release/jincaiw/mybook)](https://github.com/jincaiw/mybook/releases/latest)
[![License: CC BY 4.0](https://img.shields.io/badge/book-CC%20BY%204.0-lightgrey.svg)](LICENSE.md)

作者：**jason.wa**  
当前版本：**v0.02**

这是一本从 Git Commit、Tag、GitHub Release 开始，逐步进入 GitHub Actions、Docker、Kubernetes、Argo CD 与 GitOps 的系统教程。

## 在线阅读与下载

- 在线阅读：<https://jincaiw.github.io/mybook/>
- 最新 Release：<https://github.com/jincaiw/mybook/releases/latest>
- PDF：发布后可在 Release Assets 下载
- Markdown：[`book/book-v0.02.md`](book/book-v0.02.md)

## 内容结构

```text
Commit → Tag → Release → GitHub Actions → CI
       → Docker / GHCR → Kubernetes → Argo CD
       → GitOps → ApplicationSet → Argo Rollouts
```

全书采用正度 16 开排版，包含 30 章、教学图示、章末练习、综合实验、故障演练和参考答案。

## 仓库结构

```text
mybook/
├── book/                    # PDF 与 Markdown 正式版本
├── assets/                  # 图示和封面资源
├── docs/                    # GitHub Pages 首页
├── release-notes/           # 版本发布说明
├── scripts/                 # 校验与 Pages 构建脚本
├── .github/workflows/       # 验证、Pages、Release 自动化
├── CONTRIBUTING.md
├── CHANGELOG.md
├── CITATION.cff
└── LICENSE.md
```

## 本地校验

```bash
python3 scripts/validate.py
```

## 发布新版本

1. 更新 `VERSION`、书稿和 `CHANGELOG.md`。
2. 运行本地校验。
3. 提交并推送。
4. 创建版本 Tag，例如：

```bash
git tag -a book-1-v0.03 -m "book-1: Release v0.03"
git push origin book-1-v0.03
```

Tag 推送后，Release 工作流会自动生成 SHA256，并将 PDF、Markdown 和校验文件上传到 GitHub Release。

## 贡献

欢迎提交勘误、技术更新、案例和排版改进。开始前请阅读 [CONTRIBUTING.md](CONTRIBUTING.md)。

## 许可证

- 书籍正文与图片：CC BY 4.0
- 自动化脚本和代码示例：MIT

详情见 [LICENSE.md](LICENSE.md)。
