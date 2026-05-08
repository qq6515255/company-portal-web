# Company Portal Web

Nuxt 4 静态官网项目，默认通过 `nuxt generate` 生成 `.output/public`，适合走 `ECS + OSS + CDN` 的混合发布。

## 本地开发

```bash
npm ci
npm run dev
```

## 本地构建

```bash
npm run generate
```

构建产物输出到 `.output/public`。

## 生产发布

仓库已经配置为：

- 推送到 `master` 时触发 GitHub Actions
- 统一构建一次静态站点
- 同步静态资源到阿里云 OSS
- 刷新阿里云 CDN 缓存
- 将完整站点直接覆盖发布到阿里云 ECS 的站点目录

关键配置说明见 [scripts/README.md](/Users/xian/jx/code/company-portal-web/scripts/README.md)。

## 必要 Secrets

在 GitHub 仓库的 `Settings -> Secrets and variables -> Actions` 中至少配置：

- `ALIYUN_ACCESS_KEY_ID`
- `ALIYUN_ACCESS_KEY_SECRET`
- `ALIYUN_REGION`
- `OSS_BUCKET`
- `OSS_ENDPOINT`
- `CDN_DOMAIN`
- `NUXT_APP_CDN_URL`
- `NUXT_PUBLIC_AMAP_API_KEY`
- `NUXT_PUBLIC_AMAP_SECURITY_JS_CODE`
- `ECS_HOST`
- `ECS_DEPLOY_USER`
- `ECS_SSH_PRIVATE_KEY`

可选 Secrets：

- `ECS_SSH_PORT`
- `ECS_SITE_ROOT`
- `ECS_NGINX_SERVICE`
- `ECS_DEPLOY_PASSWORD` 或 `ECS_PASSWORD`

## ECS 目录约定

- 站点根目录：`/var/www/company-portal`
- Nginx `root`：`/var/www/company-portal`

推荐用 Git tag 做版本点管理，需要回滚时，重新部署指定 tag 即可。参考 [scripts/server-config/nginx.conf](/Users/xian/jx/code/company-portal-web/scripts/server-config/nginx.conf)。

## Tag 版本管理

```bash
git tag v1.0.0
git push origin v1.0.0
```

需要回滚时，去 GitHub Actions 手动触发 `Deploy Production`，把 `deploy_ref` 填成目标 tag，例如 `v1.0.0`。

## 当前域名建议

- 主站域名：`suntaizh.cn`
- 静态资源 CDN 域名：`cdn.suntaizh.cn`
- `CDN_DOMAIN` 填 `cdn.suntaizh.cn`
- `NUXT_APP_CDN_URL` 填 `https://cdn.suntaizh.cn`
