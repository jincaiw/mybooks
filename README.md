# MyBook 仓库

一个仓库管理多本书籍，每本书独立维护，共享 CI/CD 自动化流水线。

## 书籍

| 目录 | 说明 | 状态 |
|------|------|------|
| [`books/1.GitHub版本发布与云原生GitOps实战教程/`](books/1.GitHub版本发布与云原生GitOps实战教程/) | GitHub 版本发布与云原生 GitOps 实战教程 | ✅ v0.02 已发布 |
| [`books/2.模板书籍/`](books/2.模板书籍/) | 模板骨架（写新书从此复制） | 🔧 模板 |
| `books/N.书名/` | 更多书籍... | ⏳ 待创建 |

## 在线阅读

- **GitHub Pages**：<https://jincaiw.github.io/mybook/>

Pages 在每次推送 `main` 分支后自动构建部署，无需手动操作。

## CI/CD 流水线

| 工作流 | 触发条件 | 作用 |
|--------|----------|------|
| **Validate** | push / PR / 手动 | 校验所有书稿完整性 |
| **Pages** | push main / 手动 | 构建并部署 GitHub Pages（多本书并列展示） |
| **Release** | 推送 `*-v*` Tag / 手动 | 自动创建 GitHub Release 并上传产物 |

### 发布新版本流程

```bash
# 1. 更新 VERSION 文件
echo "0.03" > books/1.GitHub版本发布与云原生GitOps实战教程/VERSION

# 2. 更新书稿内容，生成 PDF + MD + SHA256
#    （使用 import_book.sh 导入）
cd books/1.GitHub版本发布与云原生GitOps实战教程
bash scripts/import_book.sh /path/to/book.pdf /path/to/book.md

# 3. 本地校验
python3 scripts/validate.py

# 4. 更新 CHANGELOG.md 和 release-notes/

# 5. 提交并推送
git add .
git commit -m "release: 1.GitHub版本发布与云原生GitOps实战教程 v0.03"
git push origin main

# 6. 打 Tag（命名规则：{目录名}-v{版本号}）
git tag -a 1.GitHub版本发布与云原生GitOps实战教程-v0.03 -m "1.GitHub版本发布与云原生GitOps实战教程: Release v0.03"
git push origin 1.GitHub版本发布与云原生GitOps实战教程-v0.03
#    ↑ 推送 Tag 后 Release 工作流自动运行
```

> **Tag 命名规则**：`{目录名}-v{版本号}`，例如 `1.GitHub版本发布与云原生GitOps实战教程-v0.02`、`2.模板书籍-v0.01`。  
> 工作流会自动解析出目录名和版本号。

## 添加新书

```bash
# 复制模板即可
cp -r books/2.模板书籍 books/3.新书名
# 然后修改 README.md、VERSION、docs/index.md 等内容
```

## 目录结构

```
mybook/
├── .github/workflows/       # CI/CD (validate, pages, release)
├── books/
│   ├── 1.GitHub版本发布与云原生GitOps实战教程/  # 第一本书
│   │   ├── book/            # 正式书稿 (PDF + MD + SHA256)
│   │   ├── assets/          # 图示和封面
│   │   ├── docs/            # GitHub Pages 源
│   │   ├── scripts/         # 校验和构建脚本
│   │   ├── release-notes/   # 版本发布说明
│   │   ├── VERSION
│   │   └── README.md
│   ├── 2.模板书籍/          # 模板骨架
│   └── N.书名/              # 更多书籍...
└── README.md                # 本文件
```

## 许可证

- 各本书籍正文与图片：CC BY 4.0（详见各书 LICENSE.md）
- 自动化脚本和代码示例：MIT License
