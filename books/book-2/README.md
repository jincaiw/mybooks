# 第二本书

> 这是 book-2 的模板骨架，把 README.md 改成你的书名和简介即可。

<!-- TODO: 书名与简介 -->

- 作者：
- 当前版本：v0.01
- 状态：撰写中

## 内容描述

<!-- TODO: 写清楚这本书讲什么、给谁看、学完能做什么。 -->

## 目录

<!-- TODO: 列出章节目录 -->

## 仓库结构

```
book-2/
├── book/              # 正式发布的书稿（PDF + MD + SHA256）
├── assets/            # 图片、封面等资源
├── docs/              # GitHub Pages 源
├── release-notes/     # 每版发布说明
├── scripts/           # 校验和构建脚本
└── VERSION            # 当前版本号
```

## 本地校验

```bash
python3 scripts/validate.py
```

## 发布新版本

1. 更新 `VERSION`，更新书稿和 `CHANGELOG.md`
2. 运行本地校验
3. 提交并推送
4. 打 Tag 并推送

```bash
git tag -a book-2-v0.01 -m "book-2: Release v0.01"
git push origin book-2-v0.01
```

Tag 推送后 Release 工作流会自动上传产物。
