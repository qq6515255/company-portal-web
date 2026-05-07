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
- 将完整站点发布到阿里云 ECS 的版本目录，并切换 `current` 软链接

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

## ECS 目录约定

- 站点根目录：`/var/www/company-portal`
- 版本目录：`/var/www/company-portal/releases/<git-sha>`
- 当前线上版本：`/var/www/company-portal/current`

Nginx `root` 需要指向 `current`，参考 [scripts/server-config/nginx.conf](/Users/xian/jx/code/company-portal-web/scripts/server-config/nginx.conf)。

## 当前域名建议

- 主站域名：`suntaizh.cn`
- 静态资源 CDN 域名：`cdn.suntaizh.cn`
- `CDN_DOMAIN` 填 `cdn.suntaizh.cn`
- `NUXT_APP_CDN_URL` 填 `https://cdn.suntaizh.cn`
