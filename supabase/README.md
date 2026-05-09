# Supabase 联系表单接入说明

## 1. 创建数据表

在 Supabase Dashboard 的 SQL Editor 里，直接粘贴并执行 [contact_leads.sql](/Users/xian/jx/code/company-portal-web/supabase/sql/contact_leads.sql) 的内容。

## 2. 配置前端环境变量

把下面两个变量填到项目 `.env` 或部署环境里：

- `NUXT_PUBLIC_SUPABASE_URL`
- `NUXT_PUBLIC_SUPABASE_ANON_KEY`

这两个变量会让前端把联系表单提交到 `submit-contact-lead` Edge Function。
注意：这里不需要数据库密码，前端也绝不能保存数据库连接串里的密码。

## 3. 配置 Edge Function Secrets

参考 [supabase/functions/.env.example](/Users/xian/jx/code/company-portal-web/supabase/functions/.env.example) 设置这些 Secrets：

- `SUPABASE_URL`
- `SUPABASE_SERVICE_ROLE_KEY`
- `SMTP_HOST`
- `SMTP_PORT`
- `SMTP_USER`
- `SMTP_PASSWORD`
- `CONTACT_NOTIFY_TO_EMAIL`
- `CONTACT_NOTIFY_FROM_EMAIL`
- `CONTACT_ALLOWED_ORIGIN`

官方说明：
- [Supabase Edge Functions](https://supabase.com/docs/guides/functions)
- [Supabase Edge Function Secrets](https://supabase.com/docs/guides/functions/secrets)

这里同样不要把数据库连接串密码写进仓库文件；数据库密码只用于数据库连接场景，这套实现真正使用的是 `SUPABASE_URL` 和 `SUPABASE_SERVICE_ROLE_KEY`。

QQ 邮箱 SMTP 常用配置：

- `SMTP_HOST=smtp.qq.com`
- `SMTP_PORT=465`
- `SMTP_USER=你的QQ邮箱地址`
- `SMTP_PASSWORD=QQ邮箱SMTP授权码`
- `CONTACT_NOTIFY_TO_EMAIL=782577215@qq.com`
- `CONTACT_NOTIFY_FROM_EMAIL=官网询盘 <你的QQ邮箱地址>`

## 4. 部署 Edge Functions

在已经 `supabase link` 到目标项目后执行：

```bash
supabase functions deploy submit-contact-lead
```

本仓库函数目录：

- [submit-contact-lead](/Users/xian/jx/code/company-portal-web/supabase/functions/submit-contact-lead/index.ts)

## 5. 运行方式

当前方案只需要一个后端接口：

1. 前端调用 `submit-contact-lead`
2. 函数校验并写入 `contact_leads`
3. 函数直接通过 QQ SMTP 发送通知邮件到 `782577215@qq.com`
