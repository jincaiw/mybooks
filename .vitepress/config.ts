import { defineConfig } from "vitepress";

export default defineConfig({
	lang: "zh-CN",
	title: "MyBook",
	description: "多本书籍仓库，每本书独立维护，共享 CI/CD 自动化流水线",

	base: "/",
	cleanUrls: true,
	lastUpdated: true,

	srcExclude: ["**/docs/**", "**/node_modules/**"],

	markdown: {
		lineNumbers: true,
	},

	head: [
		["meta", { name: "theme-color", content: "#1a1a2e" }],
		["link", { rel: "icon", href: "/favicon.ico" }],
	],

	ignoreDeadLinks: [/\/books\//, /book-v0\.01/],

	themeConfig: {
		// 本地全文搜索
		search: {
			provider: "local",
		},

		// 顶部导航
		nav: [
			{ text: "首页", link: "/" },
			{ text: "GitHub 仓库", link: "https://github.com/jincaiw/mybooks" },
		],

		// 左侧书籍目录
		sidebar: [
			{
				text: "GitHub 版本发布与实战教程",
				link: "/books/1.GitHub%E7%89%88%E6%9C%AC%E5%8F%91%E5%B8%83%E4%B8%8E%E5%AE%9E%E6%88%98%E6%95%99%E7%A8%8B/book/book-v0.02",
			},
			{
				text: "SRv6 网络基础教程",
				link: "/books/2.SRv6%E7%BD%91%E7%BB%9C%E5%9F%BA%E7%A1%80%E6%95%99%E7%A8%8B/book/book-v0.02",
			},
			{
				text: "高考志愿填报·红宝书",
				link: "/books/3.%E9%AB%98%E8%80%83%E5%BF%97%E6%84%BF%E5%A1%AB%E6%8A%A5%E7%BA%A2%E5%AE%9D%E4%B9%A6/book/book-v0.1",
			},
			{
				text: "Codex 橙皮书",
				link: "/books/4.codex%E6%A9%99%E7%9A%AE%E4%B9%A6/book/book-v0.1",
			},
		],

		// 编辑本页链接
		editLink: {
			pattern: "https://github.com/jincaiw/mybooks/edit/main/:path",
			text: "编辑本页",
		},

		// 最后更新时间
		lastUpdated: {
			text: "最后更新",
			formatOptions: {
				dateStyle: "full",
			},
		},

		// 社交链接
		socialLinks: [
			{
				icon: "github",
				link: "https://github.com/jincaiw/mybooks",
			},
		],

		// 页脚
		footer: {
			message: "以 CC BY 4.0 协议发布",
			copyright: "Copyright © jason.wa",
		},

		// 文档页脚导航（上一篇 / 下一篇）
		docFooter: {
			prev: "上一篇",
			next: "下一篇",
		},

		// 大纲 / 页面目录
		outline: {
			label: "本页目录",
			level: "deep",
		},

		// 返回顶部
		returnToTopLabel: "返回顶部",

		// 侧边栏菜单按钮（移动端）
		sidebarMenuLabel: "目录",

		// 深色模式切换
		darkModeSwitchLabel: "深色模式",
		lightModeSwitchTitle: "切换至浅色模式",
		darkModeSwitchTitle: "切换至深色模式",

		// 搜索文本
		notFound: {
			title: "页面未找到",
			quote: "您要查找的页面不存在。",
			linkText: "返回首页",
		},
	},
});
