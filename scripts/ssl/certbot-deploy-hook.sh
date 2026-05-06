#!/bin/bash
# ============================================
# Certbot 续签后自动钩子脚本
# 用途：证书续签成功后自动 reload Nginx / 上传 CDN
# 安装：放入 /etc/letsencrypt/renewal-hooks/deploy/
# ============================================

set -e

LOG_FILE="/var/log/certbot-deploy-hook.log"
RENEWED_DOMAINS="${RENEWED_DOMAINS:-}"
RENEWED_LINEAGE="${RENEWED_LINEAGE:-}"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

log "=== Certbot deploy hook triggered ==="
log "Domains: ${RENEWED_DOMAINS}"
log "Lineage: ${RENEWED_LINEAGE}"

# 1. Reload Nginx（如果安装了）
if command -v nginx &>/dev/null; then
    if nginx -t &>/dev/null; then
        nginx -s reload
        log "Nginx reloaded successfully"
    else
        log "WARNING: Nginx config test failed, skipping reload"
    fi
fi

# 2. 如果配置了阿里云 CDN，上传新证书
CDN_DOMAIN="${CDN_DOMAIN:-}"
if [ -n "$CDN_DOMAIN" ] && [ -f "$(dirname "$0")/upload-cert-to-cdn.sh" ]; then
    log "Uploading certificate to Aliyun CDN..."
    "$(dirname "$0")/upload-cert-to-cdn.sh" &>/dev/null || true
fi

# 3. 发送通知（可选，需要配置 webhook）
WEBHOOK_URL="${DEPLOY_WEBHOOK_URL:-}"
if [ -n "$WEBHOOK_URL" ]; then
    curl -s -X POST "$WEBHOOK_URL" \
        -H "Content-Type: application/json" \
        -d "{\"text\":\"SSL证书已续签: ${RENEWED_DOMAINS}\"}" &>/dev/null || true
fi

log "=== Deploy hook completed ==="
