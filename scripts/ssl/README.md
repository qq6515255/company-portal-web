# SSL 证书配置

## 先说结论

按你现在的架构，建议这样做：

- `suntaizh.cn` 和 `www.suntaizh.cn`：部署在 ECS + Nginx，使用 `Let's Encrypt + certbot` 自动续期
- `cdn.suntaizh.cn`：部署在阿里云 CDN，先挂证书，后续再决定是否升级到支持托管的证书

重要说明：

- 阿里云 CDN 历史免费证书已经不再适合依赖“自动续签”能力
- 阿里云数字证书管理里的个人测试证书（免费版）也不支持托管自动续期
- 所以真正能稳定做到“自动续期”的，是 ECS 上的 `certbot`

## 你的当前环境

我已经按你现网确认过这些信息：

- 系统：`Alibaba Cloud Linux 4`
- Nginx 配置目录：`/etc/nginx/conf.d/`
- 当前站点配置文件：`/etc/nginx/conf.d/company-portal-web.conf`
- 当前线上配置里还在用旧域名：`shuntaizh.com` / `www.shuntaizh.com`

这意味着在申请证书前，你需要先把 Nginx 里的域名改成：

- `suntaizh.cn`
- `www.suntaizh.cn`

## 方案一：主站 ECS 自动续期

这是你现在最推荐先做的部分。

### 1. 把域名先解析到 ECS

先确保：

- `suntaizh.cn` -> `8.138.194.144`
- `www.suntaizh.cn` -> `8.138.194.144` 或 CNAME 到 `suntaizh.cn`

证书签发前，`80` 端口必须能从公网访问。

### 2. 修改 Nginx 域名

你当前线上文件是：

`/etc/nginx/conf.d/company-portal-web.conf`

把里面的：

```nginx
server_name www.shuntaizh.com shuntaizh.com;
```

改成：

```nginx
server_name suntaizh.cn www.suntaizh.cn;
```

现在推荐直接这样配置：

```nginx
root /var/www/company-portal;
```

### 3. 安装 certbot

Alibaba Cloud Linux 4 建议用：

```bash
sudo dnf install -y certbot python3-certbot-nginx
```

### 4. 申请证书

```bash
sudo certbot --nginx -d suntaizh.cn -d www.suntaizh.cn
```

如果提示是否跳转 HTTPS：

- 选 `2`，强制跳转到 HTTPS

### 5. 验证自动续期

```bash
sudo certbot renew --dry-run
```

看到成功信息，就说明自动续期链路正常。

### 6. 安装强化版续期 timer

仓库里已经有 systemd timer：

- [certbot-renew.service](/Users/xian/jx/code/company-portal-web/scripts/ssl/certbot-renew.service)
- [certbot-renew.timer](/Users/xian/jx/code/company-portal-web/scripts/ssl/certbot-renew.timer)

在 ECS 上执行：

```bash
sudo cp /var/www/company-portal/scripts/ssl/certbot-renew.service /etc/systemd/system/
sudo cp /var/www/company-portal/scripts/ssl/certbot-renew.timer /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable certbot-renew.timer
sudo systemctl start certbot-renew.timer
sudo systemctl status certbot-renew.timer
```

这套 timer 会每天跑两次续期检查，并在成功后 reload Nginx。

## 方案二：CDN 域名 HTTPS

等你把 `cdn.suntaizh.cn` 配到阿里云 CDN 后，再处理这一层。

推荐顺序：

1. 先把 `cdn.suntaizh.cn -> CDN -> OSS` 跑通
2. 再去 CDN 控制台给 `cdn.suntaizh.cn` 开 HTTPS
3. 短期可以先手动申请/上传证书
4. 长期如果你想完全省心，再换成支持托管自动部署的证书

### CDN 证书要点

- `CDN_DOMAIN` 应填：`cdn.suntaizh.cn`
- `NUXT_APP_CDN_URL` 应填：`https://cdn.suntaizh.cn`
- 不要把 OSS Endpoint 当成 CDN 域名

## 推荐操作顺序

按你当前阶段，建议这样走：

1. 先改 ECS 的 Nginx 域名为 `suntaizh.cn` / `www.suntaizh.cn`
2. 给主站申请 `certbot` 证书并验证自动续期
3. 再配置 `cdn.suntaizh.cn`
4. 最后把 GitHub Secrets 里的 `CDN_DOMAIN` 和 `NUXT_APP_CDN_URL` 配进去

## 常见问题

### Q: 为什么不建议直接用阿里云免费证书做全自动？

因为阿里云官方当前策略下：

- CDN 历史免费证书不适合继续依赖自动续签
- 免费个人测试证书也不支持托管自动续期

所以“真正稳定的自动续期”应该放在 ECS 上，用 `certbot` 解决。

### Q: certbot 申请失败通常是什么原因？

- `suntaizh.cn` 还没解析到 ECS
- `www.suntaizh.cn` 没解析
- Nginx `server_name` 还是旧域名
- 80 端口没放通
- 站点配置语法有误，`nginx -t` 没通过

### Q: 怎么检查证书是否快过期？

仓库里有脚本：

- [check-cert.sh](/Users/xian/jx/code/company-portal-web/scripts/ssl/check-cert.sh)

示例：

```bash
/var/www/company-portal/scripts/ssl/check-cert.sh suntaizh.cn 7
```
