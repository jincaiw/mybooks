# MyBook 仓库

一个仓库管理多本书籍。

## 书籍

| 目录 | 说明 |
|------|------|
| `books/book-1/` | GitHub 版本发布与云原生 GitOps 实战教程 (v0.02) |
| `books/book-2/` | 第二本书（待填充） |
| `books/book-3/` | 第三本书（待填充） |

## 目录结构

```
.github/workflows/     # CI/CD (validate, pages, release)
books/
├── book-1/            # 第一本书
│   ├── book/           # 完整书稿 Markdown + PDF
│   ├── assets/         # 图片资源
│   ├── docs/           # GitHub Pages 源
│   ├── scripts/        # 验证和发布脚本
│   └── ...
├── book-2/            # 第二本书
└── book-3/            # 第三本书
```

每本书独立维护，互不干扰。
