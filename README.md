# MyBook 仓库

一个仓库管理多本书籍，每本书独立维护，共享 CI/CD 自动化流水线。

## 书籍

| 目录 | 说明 | 版本 |
|------|------|------|
| [`books/1.GitHub版本发布与实战教程/`](books/1.GitHub版本发布与实战教程/) | GitHub 版本发布与实战教程 | v0.02 ✅ |
| [`books/2.SRv6网络基础教程/`](books/2.SRv6网络基础教程/) | SRv6 网络基础教程 | v0.02 ✅ |
| [`books/3.高考志愿填报红宝书/`](books/3.高考志愿填报红宝书/) | 高考志愿填报决策指南 | v0.1 ✅ |
| [`books/4.codex橙皮书/`](books/4.codex橙皮书/) | Codex 橙皮书：从安装到实战案例 | v0.1 ✅ |

## 在线阅读

- **GitHub Pages**：<https://books.mujizi.com/>

Pages 在每次推送 `main` 分支后自动构建部署，无需手动操作。

## CI/CD 流水线

| 工作流 | 触发条件 | 作用 |
|--------|----------|------|
| **Validate** | push / PR / 手动 | 自动检测所有 `books/N.书名/`，并行校验 |
| **Pages** | push main / 手动 | 构建并部署 GitHub Pages，多本书并列展示 |
| **Release** | 推送 `{书名}-v{版本}` Tag / 手动 | 自动创建 GitHub Release 并上传 PDF+MD+SHA256 |

### 发布新版本

```bash
# 以第一本书为例
echo "0.03" > books/1.GitHub版本发布与实战教程/VERSION
cd books/1.GitHub版本发布与实战教程
bash scripts/import_book.sh /path/to/book.pdf /path/to/book.md
make validate
git add . && git commit -m "release: 1.GitHub版本发布与实战教程 v0.03"
git push origin main
make tag                          # 自动生成 Tag
git push origin 1.GitHub版本发布与实战教程-v0.03   # → 自动创建 Release
```

> **Tag 命名规则**：`{目录名}-v{版本号}`，例如：
>
> - `1.GitHub版本发布与实战教程-v0.03`
> - `2.SRv6网络基础教程-v0.03`
> - `3.高考志愿填报红宝书-v0.1`

> 💡 也支持根目录 Makefile 一键发布，详见 [RELEASE.md](RELEASE.md)。

## 添加新书

```bash
cp -r books/2.模板书籍 books/3.新书名
# 然后修改 README.md、VERSION、docs/index.md、docs/_config.yml 等内容
# CI/CD 自动识别新目录，无需改任何配置文件
```

## 目录结构

```
mybook/
├── .github/workflows/       # CI/CD (validate, pages, release)
├── books/
│   ├── 1.GitHub版本发布与实战教程/  # 第一本书
│   │   ├── book/            # 正式书稿 (PDF + MD + SHA256)
│   │   ├── assets/          # 图示和封面
│   │   ├── docs/            # GitHub Pages 源
│   │   ├── scripts/         # 校验和构建脚本
│   │   ├── release-notes/   # 版本发布说明
│   │   └── VERSION
│   ├── 2.SRv6网络基础教程/      # 第二本书
│   │   ├── book/            # 正式书稿 (PDF + MD + SHA256)
│   │   ├── assets/          # 20 幅插图
│   │   ├── docs/            # GitHub Pages 源
│   │   ├── scripts/         # 校验和构建脚本
│   │   ├── 实验脚本/         # 可执行实验
│   │   ├── release-notes/
│   │   └── VERSION
│   ├── 3.高考志愿填报红宝书/     # 第三本书
│   │   ├── book/            # 正式书稿 (PDF + MD + SHA256)
│   │   ├── assets/          # 封面图片
│   │   ├── docs/            # GitHub Pages 源
│   │   ├── scripts/         # 校验和构建脚本
│   │   ├── release-notes/   # 版本发布说明
│   │   └── VERSION
│   └── N.书名/              # 更多书籍...
└── README.md                # 本文件
```

## 本地预览（VitePress）

已迁移至 VitePress 构建，支持本地预览。

```bash
# 安装依赖
npm install

# 本地开发（热更新）
npm run docs:dev

# 正式构建
npm run docs:build

# 预览构建产物
npm run docs:preview
```

> VitePress 构建后，访问 `http://localhost:4173/` 查看网站。

## 自定义域名

已配置自定义域名 **books.mujizi.com**。需要完成以下 DNS 设置：

| 记录类型 | 主机记录 | 记录值 |
|----------|----------|--------|
| CNAME | books | `jincaiw.github.io.` |

并在 GitHub 仓库 `Settings → Pages → Custom domain` 中填 `books.mujizi.com`。

## 许可证

- 各本书籍正文与图片：CC BY 4.0（详见各书 LICENSE.md）
- 自动化脚本和代码示例：MIT License
