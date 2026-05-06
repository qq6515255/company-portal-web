#!/bin/bash
# ============================================
# 顺泰包装 - ECS + Nginx 优化部署脚本
# 构建 → 压缩 → SSH增量同步 → Nginx刷新
# ============================================

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() { echo -e "${GREEN}ℹ️  $1${NC}"; }
log_warn() { echo -e "${YELLOW}⚠️  $1${NC}"; }
log_error() { echo -e "${RED}❌ $1${NC}"; }
log_step() { echo -e "${BLUE}▶ $1${NC}"; }

# ========== 配置 ==========
PROJECT_NAME="suntai-portal"
LOCAL_BUILD=".output/public"
REMOTE_USER="${ECS_USER:-root}"
REMOTE_HOST="${ECS_HOST:-}"
REMOTE_DIR="/var/www/${PROJECT_NAME}"
NGINX_CONF="/etc/nginx/sites-enabled/${PROJECT_NAME}"
SSH_KEY="${SSH_KEY:-~/.ssh/id_rsa}"

# ========== 前置检查 ==========
if [ -z "$REMOTE_HOST" ]; then
    log_error "未设置 ECS_HOST 环境变量"
    echo "用法: ECS_HOST=1.2.3.4 ECS_USER=root bash scripts/deploy/ecs.sh"
    exit 1
fi

if [ ! -f "$SSH_KEY" ]; then
    log_warn "SSH 密钥不存在: $SSH_KEY"
    echo "建议配置 SSH Key 免密登录:"
    echo "  ssh-copy-id -i ~/.ssh/id_rsa.pub ${REMOTE_USER}@${REMOTE_HOST}"
    exit 1
fi

SSH_OPTS="-i ${SSH_KEY} -o StrictHostKeyChecking=no -o ConnectTimeout=10"

# ========== Step 1: 构建 ==========
log_step "[1/5] 构建生产版本"

# 先清理旧构建，避免残留
rm -rf .output

# 使用 pnpm 如果可用，否则 npm
if command -v pnpm &> /dev/null; then
    pnpm install --frozen-lockfile
    pnpm generate
else
    npm ci
    npm run generate
fi

if [ ! -d "$LOCAL_BUILD" ]; then
    log_error "构建产物不存在！"
    exit 1
fi

BUILD_SIZE=$(du -sh "$LOCAL_BUILD" | cut -f1)
log_info "构建完成: ${BUILD_SIZE}"

# ========== Step 2: 压缩静态资源（可选但强烈建议） ==========
log_step "[2/5] 预压缩静态资源"

# Gzip 预压缩（Nginx gzip_static 用）
find "$LOCAL_BUILD" -type f \( \
    -name "*.js" -o -name "*.css" -o -name "*.html" -o \
    -name "*.json" -o -name "*.xml" -o -name "*.svg" \
\) -exec gzip -kf9 {} \; 2>/dev/null || true

# Brotli 预压缩（如果系统支持）
if command -v brotli &> /dev/null; then
    find "$LOCAL_BUILD" -type f \( \
        -name "*.js" -o -name "*.css" -o -name "*.html" -o \
        -name "*.json" -o -name "*.xml" -o -name "*.svg" \
    \) -exec brotli -kfZ {} \; 2>/dev/null || true
    log_info "Brotli 预压缩完成"
fi

# ========== Step 3: 服务器环境检查 ==========
log_step "[3/5] 检查服务器环境"

ssh $SSH_OPTS ${REMOTE_USER}@${REMOTE_HOST} "
    # 创建目录
    sudo mkdir -p ${REMOTE_DIR}
    sudo chown -R \${USER}:\${USER} ${REMOTE_DIR}

    # 检查 Nginx
    if ! command -v nginx &> /dev/null; then
        echo 'nginx_not_installed'
    else
        echo 'nginx_ok'
    fi
" > /tmp/ecs_check.txt

ECS_CHECK=$(cat /tmp/ecs_check.txt | tail -1)
if [ "$ECS_CHECK" = "nginx_not_installed" ]; then
    log_warn "服务器未安装 Nginx，请先在 ECS 上执行:"
    echo "  sudo apt update && sudo apt install -y nginx"
    exit 1
fi

# ========== Step 4: 增量同步到 ECS ==========
log_step "[4/5] 同步文件到 ECS"

# rsync 参数说明：
# -a 归档模式（保留权限、时间戳）
# -z 传输时压缩
# --delete 删除远程多余文件
# --exclude 排除不需要的文件
rsync -az --delete \
    -e "ssh ${SSH_OPTS}" \
    --exclude='.DS_Store' \
    --exclude='Thumbs.db' \
    --exclude='*.map' \
    "$LOCAL_BUILD/" \
    ${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_DIR}/

log_info "文件同步完成"

# ========== Step 5: 设置权限 & 检查 Nginx ==========
log_step "[5/5] 设置权限并验证"

ssh $SSH_OPTS ${REMOTE_USER}@${REMOTE_HOST} "
    # 设置正确权限（nginx 用户可读）
    sudo chown -R www-data:www-data ${REMOTE_DIR}
    sudo chmod -R 755 ${REMOTE_DIR}

    # 测试 Nginx 配置
    if sudo nginx -t; then
        sudo nginx -s reload
        echo 'nginx_reloaded'
    else
        echo 'nginx_config_error'
    fi
" > /tmp/nginx_result.txt

NGINX_RESULT=$(cat /tmp/nginx_result.txt | tail -1)
if [ "$NGINX_RESULT" = "nginx_reloaded" ]; then
    log_info "Nginx 已重新加载"
else
    log_error "Nginx 配置有误，请检查"
    exit 1
fi

# ========== 完成 ==========
echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}  ✅ 部署完成！${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo -e "  服务器: ${REMOTE_USER}@${REMOTE_HOST}"
echo -e "  路径:   ${REMOTE_DIR}"
echo -e "  大小:   ${BUILD_SIZE}"
echo ""

# 可选：测速
if command -v curl &> /dev/null; then
    log_info "测试首页响应..."
    HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" "http://${REMOTE_HOST}/" || echo "000")
    if [ "$HTTP_CODE" = "200" ]; then
        log_info "首页响应正常 (HTTP 200)"
    else
        log_warn "首页响应异常 (HTTP ${HTTP_CODE})"
    fi
fi

echo ""
