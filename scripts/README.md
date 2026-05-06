# 部署指南

## 方案选择

| 方案 | 成本/月 | 复杂度 | 访问速度 | 推荐场景 |
|---|---|---|---|---|
| **OSS + CDN** | ~¥10-30 | 低 | 全球加速 | 纯静态站、**推荐** |
| ECS + Nginx | ~¥50-200 | 中 | 单地域 | 已有服务器、需后端 API |

本项目是 Nuxt SSG 纯静态站点，**强烈推荐 OSS + CDN 方案**。

---

## 方案 A：OSS + CDN（推荐）

### 第一步：阿里云控制台配置

#### 1. 创建 OSS Bucket

1. 登录 [阿里云 OSS 控制台](https://oss.console.aliyun.com/)
2. 点击「创建 Bucket」
3. 配置：
   - **Bucket 名称**：如 `suntai-portal`（全局唯一）
   - **地域**：选择靠近你的用户的地域（如华南选 `oss-cn-shenzhen`）
   - **存储类型**：标准存储
   - **读写权限**：公共读（静态网站必需）
4. 在 Bucket 设置中开启「静态页面」：
   - 默认首页：`index.html`
   - 默认 404 页：`404.html`

#### 2. 绑定自定义域名

1. 在 Bucket 的「传输管理」→「域名管理」中添加域名：
   - 如 `www.suntaizh.cn`
2. 按提示配置 DNS CNAME 记录
3. 开启 HTTPS（申请免费 SSL 证书）

#### 3. 配置 CDN 加速

1. 登录 [阿里云 CDN 控制台](https://cdn.console.aliyun.com/)
2. 添加加速域名：
   - **加速域名**：`www.suntaizh.cn`
   - **源站类型**：OSS 域名
   - **源站地址**：选择你的 OSS Bucket 外网域名
3. 等待 CDN 审核（约 10 分钟）
4. 修改 DNS：将域名 CNAME 指向 CDN 分配的加速域名

#### 4. 创建 RAM 访问凭证

1. 登录 [阿里云 RAM 控制台](https://ram.console.aliyun.com/)
2. 创建用户（如 `github-deploy`）
3. 勾选「OpenAPI 调用访问」
4. 保存 **AccessKey ID** 和 **AccessKey Secret**（只显示一次！）
5. 给用户授权：
   - `AliyunOSSFullAccess`（OSS 完全访问）
   - `AliyunCDNFullAccess`（CDN 完全访问）

---

### 第二步：GitHub Actions 自动部署（推荐）

#### 1. 配置 GitHub Secrets

在 GitHub 仓库 → Settings → Secrets and variables → Actions → New repository secret：

| Secret 名称 | 值 |
|---|---|
| `ALIYUN_ACCESS_KEY_ID` | 你的 AccessKey ID |
| `ALIYUN_ACCESS_KEY_SECRET` | 你的 AccessKey Secret |
| `OSS_BUCKET` | 如 `suntai-portal` |
| `OSS_REGION` | 如 `oss-cn-shenzhen` |
| `OSS_ENDPOINT` | 如 `oss-cn-shenzhen.aliyuncs.com` |
| `CDN_DOMAIN` | 如 `www.suntaizh.cn` |

#### 2. 触发部署

```bash
# 推送到 main 分支，自动触发
git add .
git commit -m "feat: update content"
git push origin main
```

#### 3. 查看部署状态

在 GitHub 仓库 → Actions 标签页查看每次部署日志。

---

### 第三步：本地手动部署（备选）

```bash
# 1. 复制并填写配置
cp .env.example .env
# 编辑 .env，填入你的阿里云凭证

# 2. 一键部署
npm run deploy
# 或
bash scripts/deploy/oss-cdn.sh
```

---

## 方案 B：ECS + Nginx

适合已有 ECS 服务器或需要后端 API 的场景。

```bash
# 1. 服务器初始化（SSH 到 ECS）
sudo apt update && sudo apt install -y nginx
sudo mkdir -p /var/www/suntai-portal

# 2. 复制 Nginx 配置
sudo cp scripts/server-config/nginx.conf /etc/nginx/sites-enabled/suntai-portal
sudo nginx -t && sudo systemctl restart nginx

# 3. 配置 SSH Key（本地执行）
ssh-copy-id -i ~/.ssh/id_rsa.pub root@你的ECS公网IP

# 4. 本地部署
ECS_HOST=你的ECS公网IP bash scripts/deploy/ecs.sh
```

---

## 配置 HTTPS

### OSS + CDN 方案

在阿里云 CDN 控制台直接申请免费 SSL 证书，一键绑定。

### ECS 方案

```bash
# 安装 certbot
sudo apt install -y certbot python3-certbot-nginx

# 申请证书（替换为你的域名）
sudo certbot --nginx -d suntaizh.cn -d www.suntaizh.cn

# 自动续期已配置，无需额外操作
```

---

## 常见问题

### Q: 部署后页面还是旧的？

CDN 有缓存，等 5-10 分钟或手动刷新：
- GitHub Actions 中已自动调用 CDN 刷新 API
- 本地部署脚本也会自动刷新
- 紧急时去阿里云 CDN 控制台手动「刷新预热」

### Q: 图片加载慢？

OSS + CDN 方案下，所有静态资源自动走 CDN，首次访问后全球节点都有缓存。

### Q: 成本多少？

- OSS 存储：1GB 约 ¥0.12/月（你的网站 < 100MB）
- CDN 流量：1GB 约 ¥0.24（新用户有免费额度）
- **总计：月访问量 1 万次以内，费用约 ¥5-20/月**

### Q: 可以两个方案同时用吗？

可以。例如：
- 主站 `www.suntaizh.cn` → OSS + CDN
- 后台管理 `admin.suntaizh.cn` → ECS + Nginx
