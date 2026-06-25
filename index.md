---
title: jason.wa的电子书库
editLink: false
lastUpdated: false
---

# 📚 jason.wa的电子书库

<div class="tagline">从版本发布到网络技术，从高考志愿到 AI 工具——四本书，四种视角</div>

<div class="book-grid">

<div class="book-card">

## GitHub 版本发布与实战教程

从 Git Commit、Tag、GitHub Release 开始，逐步进入 GitHub Actions、Docker、Kubernetes 与 GitOps 的系统教程。

**作者：** jason.wa  
**版本：** v0.02  
**章节：** 30 章

<div class="book-links">

[在线阅读 →](/books/1.GitHub%E7%89%88%E6%9C%AC%E5%8F%91%E5%B8%83%E4%B8%8E%E5%AE%9E%E6%88%98%E6%95%99%E7%A8%8B/book/book-v0.02)
[下载 PDF](https://github.com/jincaiw/mybooks/releases/latest)
[GitHub 仓库](https://github.com/jincaiw/mybooks)

</div>
</div>

<div class="book-card">

## SRv6 网络基础教程

RFC 8754 / RFC 8986 图解、Linux 实验、VPN、运维与故障排查。

**作者：** jason.wa  
**版本：** v0.02

<div class="book-links">

[在线阅读 →](/books/2.SRv6%E7%BD%91%E7%BB%9C%E5%9F%BA%E7%A1%80%E6%95%99%E7%A8%8B/book/book-v0.02)
[下载 PDF](https://github.com/jincaiw/mybooks/releases/latest)

</div>
</div>

<div class="book-card">

## 高考志愿填报·红宝书

从「能录取」走向「适合发展」——位次 × 院校 × 专业 × 城市 × 产业 × 就业。

**作者：** jason.wa  
**版本：** V0.1-R1

<div class="book-links">

[在线阅读 →](/books/3.%E9%AB%98%E8%80%83%E5%BF%97%E6%84%BF%E5%A1%AB%E6%8A%A5%E7%BA%A2%E5%AE%9D%E4%B9%A6/book/book-v0.1)
[下载 PDF](https://github.com/jincaiw/mybooks/releases/latest)

</div>
</div>

<div class="book-card">

## Codex 橙皮书

从安装到实战案例的全链路 Codex 使用指南。写给开发者、独立开发者和 AI 工具重度用户。

**作者：** 泊舟  
**版本：** v0.1

<div class="book-links">

[在线阅读 →](/books/4.codex%E6%A9%99%E7%9A%AE%E4%B9%A6/book/book-v0.1)
[下载 PDF](https://github.com/jincaiw/mybooks/releases/latest)

</div>
</div>

</div>

<style scoped>
.tagline {
  font-size: 1.05rem;
  color: var(--vp-c-text-2);
  margin-top: -0.5rem;
  margin-bottom: 2rem;
  line-height: 1.6;
}

.book-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(360px, 1fr));
  gap: 1.25rem;
  margin: 1.5rem 0;
}

.book-card {
  background: var(--vp-c-bg-elv);
  border: 1px solid var(--vp-c-border);
  border-radius: 10px;
  padding: 1.5rem 1.5rem 1.75rem;
  transition: all 0.2s ease;
}

.book-card:hover {
  border-color: var(--vp-c-brand-2);
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.06);
  transform: translateY(-2px);
}

.book-card h2 {
  font-size: 1.15rem;
  font-weight: 600;
  margin-top: 0;
  margin-bottom: 0.6rem;
  border: none;
  padding: 0;
  line-height: 1.4;
}

.book-card p {
  font-size: 0.9rem;
  line-height: 1.65;
  color: var(--vp-c-text-2);
  margin-bottom: 0.75rem;
}

.book-card .book-links {
  display: flex;
  flex-wrap: wrap;
  gap: 0.5rem;
  margin-top: 0.75rem;
  padding-top: 0.75rem;
  border-top: 1px solid var(--vp-c-divider);
}

.book-card .book-links a {
  display: inline-flex;
  align-items: center;
  gap: 0.25rem;
  font-size: 0.85rem;
  font-weight: 500;
  padding: 0.3rem 0.7rem;
  border-radius: 6px;
  background: var(--vp-c-bg-soft);
  color: var(--vp-c-brand-1);
  transition: background 0.2s;
}

.book-card .book-links a:hover {
  background: color-mix(in srgb, var(--vp-c-brand-3) 20%, transparent);
}

@media (max-width: 768px) {
  .book-grid {
    grid-template-columns: 1fr;
  }
}
</style>
