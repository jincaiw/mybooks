# Codex 橙皮书 V0.1

**从安装到实战案例的全链路 Codex 使用指南**

> 非官方开源指南 · 持续更新版  
> 写给开发者、独立开发者和 AI 工具重度用户的 Codex 使用手册。

- 作者：**泊舟**
- 当前版本：**v0.1**
- 状态：已发布
- 原始仓库：[/jincaiw/codex-orange-book](https://github.com/jincaiw/codex-orange-book)

## 内容描述

本书系统讲解 Codex 的使用方法，从基础认知到安装配置，再到核心功能（自动化、插件、Skill、MCP、云端运行）和标准工作流，最后通过实战案例（宠物零食网站、管理后台、招商 PPT、宣传视频）演示完整工作流。

### 目录

1. 第一篇：先搞懂 Codex 是什么
2. 第二篇：安装、配置与环境准备
3. 第三篇：核心功能详解
4. 第四篇：标准工作流
5. 第五篇：实战案例库
6. 附录：第三方模型接入

## 仓库结构

```
4.codex橙皮书/
├── book/              # 正式发布的书稿（PDF + MD + SHA256）
├── assets/            # 图片资源（108 幅插图）
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
git tag -a 4.codex橙皮书-v0.1 -m "4.codex橙皮书: Release v0.1"
git push origin 4.codex橙皮书-v0.1
```

Tag 推送后 Release 工作流会自动上传产物。
