# Release 发布操作手册

> 每本书独立版本管理，通过 Tag 驱动 CI/CD 自动创建 GitHub Release。

---

## 发布流程全景

```
本地: 改版本 → 导入书稿 → 校验 → 提交 → 推送 main
                                        ↓
                                   CI Validate (自动)
                                        ↓
                             手动: 打 Tag → 推送 Tag
                                        ↓
                                CI Release (自动)
                                        ↓
                              GitHub Release 创建完成
                                        ↓
                              GitHub Pages 自动部署更新
```

---

## 前提条件

- 书稿（PDF + MD）已定稿
- VERSION 文件决定发布版本号
- release-notes/ 或 CHANGELOG.md 记录了本版变更（至少有一个即可）

---

## 详细操作步骤

### 第 1 步：更新版本号

```bash
# 写入新版本号
echo "0.03" > books/1.GitHub版本发布与实战教程/VERSION
```

版本号规则：遵循语义化版本 `主版本.次版本`，如 `0.1`、`0.02`、`1.0`。

> ⚠️ VERSION 文件内容必须与书稿 markdown 中出现的版本号子串匹配。
> 例如 VERSION=`0.1` → markdown 中需要有 `0.1`（如 `V0.1` 即包含 `0.1`）。

### 第 2 步：导入书稿

```bash
cd books/1.GitHub版本发布与实战教程
bash scripts/import_book.sh /path/to/book.pdf /path/to/book.md
```

该命令会：

1. 复制 PDF → `book/book-v{VERSION}.pdf`
2. 复制 MD → `book/book-v{VERSION}.md`
3. 生成 SHA256 校验和 → `book/SHA256SUMS.txt`
4. 自动运行校验

> 📝 书稿中的图片路径应使用 `../assets/文件名` 格式，图片放在本目录的 `assets/` 下。

### 第 3 步：更新变更记录（二选一）

**方式 A：release-notes 文件（推荐）**

```bash
# 创建 release-notes/v{VERSION}.md
cat > release-notes/v0.03.md << 'EOF'
# v0.03 版本标题

## 主要内容

- 新功能 / 修正摘要
- ...

## Release Assets

- PDF 印刷定稿版
- Markdown 源稿
- SHA256 校验文件
EOF
```

**方式 B：只更新 CHANGELOG.md**

release.yml 会自动从 CHANGELOG 中提取对应版本条目作为 Release Notes。
如果没有 release-notes 文件也没有 CHANGELOG 条目，Release Notes 为空。

### 第 4 步：本地校验

```bash
# 方式一：单本书校验
cd books/1.GitHub版本发布与实战教程
make validate

# 方式二：从根目录校验全部
cd /path/to/mybook
make validate

# 方式三：从根目录校验单本
make validate-one BOOK=1.GitHub版本发布与实战教程
```

校验通过应输出：`Validation passed for v0.03`

### 第 5 步：提交到 Git

```bash
cd /path/to/mybook
git add .
git commit -m "release: 1.GitHub版本发布与实战教程 v0.03"
git push origin main
```

推送后 CI 自动运行：

- ✅ **Validate** — 自动检测所有书目录，并行校验
- ✅ **GitHub Pages** — 自动构建部署（稍等几分钟生效）

### 第 6 步：打 Tag 并推送 → 自动创建 Release

```bash
# 方式一：使用 Makefile
cd books/1.GitHub版本发布与实战教程
make tag
# 输出: Created tag 1.GitHub版本发布与实战教程-v0.03. Push with: git push origin 1.GitHub版本发布与实战教程-v0.03

# 方式二：手动打 Tag
git tag -a 1.GitHub版本发布与实战教程-v0.03 -m "1.GitHub版本发布与实战教程: Release v0.03"

# 推送 Tag → 触发 CI Release
git push origin 1.GitHub版本发布与实战教程-v0.03
```

推送 Tag 后 CI 自动：

1. 校验书稿完整性
2. 验证 Tag 版本号与 VERSION 文件一致
3. 读取 release-notes/ 或 CHANGELOG 作为 Release Notes
4. 上传 PDF + MD + SHA256 到 Release 附件
5. 发布 Release

---

## 一键发布（根目录 Makefile）

```bash
# 在项目根目录执行
make release BOOK=1.GitHub版本发布与实战教程
# 等效于: make validate-one + make tag

# 然后推送
git push origin main
git push origin 1.GitHub版本发布与实战教程-v0.03
```

---

## 发布检查清单

| # | 检查项 | 命令/方法 |
|---|--------|-----------|
| 1 | VERSION 文件已更新 | `cat books/书名/VERSION` |
| 2 | 书稿 PDF+MD 已导入 | `ls books/书名/book/` |
| 3 | 封面图片在 assets/ 中 | `ls books/书名/assets/` |
| 4 | 图片引用路径正确 | `grep '](\.\./assets/' books/书名/book/book-v*.md` |
| 5 | 本地校验通过 | `make validate-one BOOK=书名` |
| 6 | SHA256 已更新 | `cat books/书名/book/SHA256SUMS.txt` |
| 7 | CHANGELOG 或 release-notes 已更新 | 任一即可 |
| 8 | git commit + push | `git push origin main` |
| 9 | Tag 已创建并推送 | `git push origin 书名-v版本号` |
| 10 | 确认 Release 已创建 | 浏览器查看 GitHub Releases 页面 |

---

## Tag 命名规则

```
{目录名}-v{版本号}
```

示例：

- `1.GitHub版本发布与实战教程-v0.03`
- `2.SRv6网络基础教程-v0.02`
- `3.高考志愿填报红宝书-v0.1`

目录名就是 `books/` 下的文件夹名称，版本号来自 `VERSION` 文件。

---

## CI/CD 工作流说明

| 工作流文件 | 触发条件 | 作用 |
|-----------|---------|------|
| `.github/workflows/validate.yml` | 推送 main / PR / 手动 | 自动检测所有书目录，并行校验完整性 |
| `.github/workflows/pages.yml` | 推送 main / 手动 | 构建并部署 GitHub Pages 站点 |
| `.github/workflows/release.yml` | 推送 Tag `*-v*` / 手动 | 创建 GitHub Release 并上传产物 |

Pages 站点地址：<https://jincaiw.github.io/mybooks/>

---

## 回滚 / 修复

如果发布后发现错误：

```bash
# 删除 Tag（本地 + 远程）
git tag -d 1.GitHub版本发布与实战教程-v0.03
git push origin :refs/tags/1.GitHub版本发布与实战教程-v0.03

# 修复书稿
# ...

# 重新提交
git add .
git commit -m "fix: 修复 v0.03 发布问题"
git push origin main

# 重新打 Tag
make tag
git push origin 1.GitHub版本发布与实战教程-v0.03
```

> ⚠️ GitHub Release 删除后不可恢复，Tag 删除后可重新创建。
> 如果 Release 已创建但需要修正，建议递增版本号发布 `v0.04`。
