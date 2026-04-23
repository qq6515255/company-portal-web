# 国内 SEO 平台注册指南

## 1. 百度搜索资源平台 (最重要)

**注册地址**: https://ziyuan.baidu.com/

### 验证网站
1. 登录百度搜索资源平台
2. 添加网站: suntaizh.cn
3. 选择验证方式（推荐 TXT 记录验证）
4. 将提供的验证码填入 nuxt.config.ts:
```ts
{ name: 'baidu-site-verification', content: '你的验证码' }
```

### 提交 sitemap
1. 验证通过后
2. 进入"数据提交" → "sitemap"
3. 提交: https://suntaizh.cn/sitemap.xml

### 快速收录
- 使用"快速收录"功能提交重要页面
- 定期提交新内容

---

## 2. 360 站长平台

**注册地址**: https://zhanzhang.so.com/

### 验证方式
1. 添加网站
2. 选择 TXT 验证
3. 填入 nuxt.config.ts:
```ts
{ name: '360-site-verification', content: '你的验证码' }
```

---

## 3. 搜狗站长平台

**注册地址**: https://zhanzhang.sogou.com/

### 验证方式
1. 添加网站
2. 选择 TXT 验证或文件验证
3. 填入 nuxt.config.ts:
```ts
{ name: 'sogou-site-verification', content: '你的验证码' }
```

---

## 4. 神马搜索

**注册地址**: https://zhanzhang.sm.cn/

### 验证方式
- 使用 mip 组件或 TXT 验证

---

## 5. Google Search Console (国际)

**注册地址**: https://search.google.com/search-console

虽然主要面向谷歌，但能查看国际搜索情况

---

## 提交优先级

| 平台 | 优先级 | 收录效果 |
|------|--------|----------|
| 百度搜索资源平台 | ⭐⭐⭐⭐⭐ | 最佳 |
| 360 站长平台 | ⭐⭐⭐ | 一般 |
| 搜狗站长平台 | ⭐⭐⭐ | 一般 |
| 神马搜索 | ⭐⭐ | 移动端 |

---

## 验证后操作

1. **提交sitemap**: 所有平台都支持 sitemap 提交
2. **定期更新**: 有新内容时主动提交
3. **检查抓取**: 在平台查看爬虫抓取日志
4. **修复错误**: 及时处理平台提示的抓取错误

---

## 关键词优化建议

核心关键词（title必含）:
- 珠海包装材料
- 珍珠棉
- 透明胶带
- 双面胶
- 打包带

长尾关键词:
- 珠海珍珠棉厂家
- 泡沫棉批发
- 包装材料定制
- 珠海包装厂
- 中山包装材料
