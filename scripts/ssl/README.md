# SSL 证书自动续签配置

## 方案选择

| 部署方式 | 证书来源 | 续签方式 | 操作复杂度 |
|---|---|---|---|
| **OSS + CDN** | 阿里云免费证书 | **全自动，无需操作** | 零 |
| **OSS + CDN** | Let's Encrypt | 需脚本自动上传 CDN | 中 |
| **ECS + Nginx** | Let's Encrypt / Certbot | 需配置 cron 自动续签 + reload | 低 |

> **推荐**：如果你用 OSS + CDN 方案，直接用阿里云免费证书，完全零维护。
>
> 以下文档覆盖所有场景的完整配置。

---

## 方案一：OSS + CDN + 阿里云免费证书（推荐，零维护）

阿里云 CDN 控制台提供 **免费 DV SSL 证书**，申请后自动部署到 CDN 节点，**到期前 30 天自动续签**，完全无需人工干预。

### 配置步骤

1. 登录 [阿里云 CDN 控制台](https://cdn.console.aliyun.com/)
2. 进入域名管理 → 选择你的加速域名
3. 点击「HTTPS 配置」→「修改配置」
4. 开启 HTTPS，选择「免费证书」
5. 点击「申请免费证书」，按提示验证域名所有权
6. 等待证书签发（通常 1-5 分钟）
7. 开启「强制跳转 HTTPS」
8. 开启「HTTP/2」

### 自动续签

✅ **已完成。阿里云会自动处理。**

证书到期前 30 天，系统会自动申请新证书并部署到所有 CDN 节点，无需任何操作。

---

## 方案二：OSS + CDN + Let's Encrypt（自定义证书）

如果你需要用 Let's Encrypt 证书（比如通配符证书 `*.suntaizh.cn`），需要配合脚本自动上传到阿里云 CDN。

### 前置要求

- 一台可以运行 certbot 的服务器（可以是本地 Mac、CI 服务器、或最便宜的 ECS）
- 域名 DNS 解析在阿里云（支持 DNS-01 挑战）

### 配置步骤

#### 1. 安装 certbot 和阿里云 DNS 插件

```bash
# macOS
brew install certbot
pip3 install certbot-dns-aliyun

# Ubuntu/Debian
sudo apt update
sudo apt install -y certbot python3-certbot-dns-aliyun
```

#### 2. 配置阿里云 DNS API 凭证

创建 `/etc/letsencrypt/aliyun-dns.ini`：

```ini
dns_aliyun_access_key = 你的AccessKeyID
dns_aliyun_access_key_secret = 你的AccessKeySecret
```

设置权限：

```bash
sudo chmod 600 /etc/letsencrypt/aliyun-dns.ini
```

#### 3. 申请证书

```bash
sudo certbot certonly \
  --dns-dns_aliyun \
  --dns-dns_aliyun-credentials /etc/letsencrypt/aliyun-dns.ini \
  -d suntaizh.cn \
  -d www.suntaizh.cn \
  -d *.suntaizh.cn
```

#### 4. 配置自动上传到 CDN（见下方脚本）

---

## 方案三：ECS + Nginx + Let's Encrypt

### 1. 安装 certbot

```bash
# Ubuntu/Debian
sudo apt update
sudo apt install -y certbot python3-certbot-nginx

# CentOS/RHEL
sudo yum install -y certbot python3-certbot-nginx
```

### 2. 申请证书

```bash
sudo certbot --nginx -d suntaizh.cn -d www.suntaizh.cn
```

按提示选择：
- 是否重定向 HTTP 到 HTTPS → 选择 2（全部重定向）

### 3. 验证自动续签

```bash
# 测试续签（模拟，不会真的续签）
sudo certbot renew --dry-run
```

如果显示 `Congratulations, all renewals succeeded`，说明配置正确。

### 4. 配置强化版自动续签脚本

certbot 默认安装了 systemd timer 或 cron 任务，但**默认不会 reload Nginx**，导致续签后新证书不生效。

使用我们提供的强化脚本（见 `ssl/renew.sh`）：

```bash
sudo cp scripts/ssl/certbot-renew.service /etc/systemd/system/
sudo cp scripts/ssl/certbot-renew.timer /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable certbot-renew.timer
sudo systemctl start certbot-renew.timer
```

---

## 证书监控与告警

建议配置证书到期监控，提前 7 天收到告警：

### 方法一：阿里云云监控（推荐）

在阿里云 CDN 控制台开启「证书过期提醒」，到期前 30/15/7 天自动短信/邮件通知。

### 方法二：自定义脚本监控

见 `scripts/ssl/check-cert.sh`，可集成到 GitHub Actions 或服务器 cron：

```bash
# 每周一检查证书有效期
0 9 * * 1 /var/www/suntai-portal/scripts/ssl/check-cert.sh suntaizh.cn 7
```

---

## 常见问题

### Q: 阿里云免费证书和 Let's Encrypt 有什么区别？

| 对比项 | 阿里云免费证书 | Let's Encrypt |
|---|---|---|
| 价格 | 免费 | 免费 |
| 有效期 | 1年 | 90天 |
| 续签 | 自动 | 需配置 |
| 通配符 | 不支持 | 支持 |
| 多域名 | 支持 | 支持 |
| 信任度 | 主流浏览器都信任 | 主流浏览器都信任 |

**建议**：单域名/双域名用阿里云免费证书；需要通配符用 Let's Encrypt。

### Q: 续签失败了怎么办？

1. 检查 certbot 日志：`sudo cat /var/log/letsencrypt/letsencrypt.log`
2. 手动测试：`sudo certbot renew --dry-run --verbose`
3. 检查 80 端口是否被占用
4. 检查域名 DNS 解析是否正常

### Q: 如何查看证书有效期？

```bash
# 查看本地证书
sudo openssl x509 -in /etc/letsencrypt/live/suntaizh.cn/fullchain.pem -noout -dates

# 查看线上证书（任意机器）
echo | openssl s_client -servername suntaizh.cn -connect suntaizh.cn:443 2>/dev/null | openssl x509 -noout -dates
```
