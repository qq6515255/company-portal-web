#!/bin/bash
# ============================================
# SSL 证书有效期监控脚本
# 用法: check-cert.sh [域名] [提前告警天数]
# 示例: check-cert.sh suntaizh.cn 7
# ============================================

DOMAIN="${1:-suntaizh.cn}"
WARN_DAYS="${2:-14}"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log_info() { echo -e "${GREEN}[OK]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[CRITICAL]${NC} $1"; }

# 获取证书到期日期
EXPIRY_DATE=$(echo | openssl s_client -servername "${DOMAIN}" -connect "${DOMAIN}:443" 2>/dev/null | \
    openssl x509 -noout -enddate 2>/dev/null | cut -d= -f2)

if [ -z "$EXPIRY_DATE" ]; then
    log_error "无法获取 ${DOMAIN} 的证书信息"
    exit 1
fi

# 转换日期格式并计算剩余天数
EXPIRY_EPOCH=$(date -d "$EXPIRY_DATE" +%s 2>/dev/null || date -j -f "%b %d %H:%M:%S %Y %Z" "$EXPIRY_DATE" +%s 2>/dev/null)
NOW_EPOCH=$(date +%s)
DAYS_LEFT=$(( (EXPIRY_EPOCH - NOW_EPOCH) / 86400 ))

EXPIRY_FORMATTED=$(date -d "$EXPIRY_DATE" "+%Y-%m-%d" 2>/dev/null || date -j -f "%b %d %H:%M:%S %Y %Z" "$EXPIRY_DATE" "+%Y-%m-%d" 2>/dev/null)

# 输出结果
if [ "$DAYS_LEFT" -lt 0 ]; then
    log_error "证书已过期 ${DOMAIN} (过期 ${EXPIRY_FORMATTED})"
    exit 2
elif [ "$DAYS_LEFT" -lt 3 ]; then
    log_error "证书即将过期: ${DOMAIN} | 剩余 ${DAYS_LEFT} 天 | 到期 ${EXPIRY_FORMATTED}"
    exit 2
elif [ "$DAYS_LEFT" -lt "$WARN_DAYS" ]; then
    log_warn "证书即将过期: ${DOMAIN} | 剩余 ${DAYS_LEFT} 天 | 到期 ${EXPIRY_FORMATTED}"
    exit 1
else
    log_info "证书正常: ${DOMAIN} | 剩余 ${DAYS_LEFT} 天 | 到期 ${EXPIRY_FORMATTED}"
    exit 0
fi
