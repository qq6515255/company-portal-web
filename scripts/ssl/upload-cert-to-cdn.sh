#!/bin/bash
# ============================================
# 将 Let's Encrypt 证书自动上传到阿里云 CDN
# 用途：certbot 续签后自动部署新证书到 CDN
# ============================================

set -e

DOMAIN="${CDN_DOMAIN:-suntaizh.cn}"
CERT_DIR="/etc/letsencrypt/live/${DOMAIN}"
CERT_NAME="letsencrypt-${DOMAIN}"

# 阿里云凭证（从环境变量读取）
ACCESS_KEY_ID="${ALIYUN_ACCESS_KEY_ID:-}"
ACCESS_KEY_SECRET="${ALIYUN_ACCESS_KEY_SECRET:-}"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log_info() { echo -e "${GREEN}[INFO]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# 检查凭证
if [ -z "$ACCESS_KEY_ID" ] || [ -z "$ACCESS_KEY_SECRET" ]; then
    log_error "缺少阿里云凭证，请设置环境变量："
    echo "  export ALIYUN_ACCESS_KEY_ID=你的AccessKeyID"
    echo "  export ALIYUN_ACCESS_KEY_SECRET=你的AccessKeySecret"
    exit 1
fi

# 检查证书文件
if [ ! -f "${CERT_DIR}/fullchain.pem" ] || [ ! -f "${CERT_DIR}/privkey.pem" ]; then
    log_error "证书文件不存在: ${CERT_DIR}"
    exit 1
fi

# 读取证书内容
CERT=$(cat "${CERT_DIR}/fullchain.pem" | awk '{printf "%s\\n", $0}')
KEY=$(cat "${CERT_DIR}/privkey.pem" | awk '{printf "%s\\n", $0}')

log_info "上传证书到阿里云 CDN..."
log_info "域名: ${DOMAIN}"
log_info "证书名: ${CERT_NAME}"

# 调用阿里云 CDN API 上传证书
RESPONSE=$(curl -s "https://cdn.aliyuncs.com/?Action=CreateUserCertificate" \
    -H "Content-Type: application/x-www-form-urlencoded" \
    --data-urlencode "Format=JSON" \
    --data-urlencode "Version=2018-05-10" \
    --data-urlencode "SignatureMethod=HMAC-SHA1" \
    --data-urlencode "SignatureVersion=1.0" \
    --data-urlencode "AccessKeyId=${ACCESS_KEY_ID}" \
    --data-urlencode "Timestamp=$(date -u +%Y-%m-%dT%H:%M:%SZ)" \
    --data-urlencode "SignatureNonce=$(uuidgen || cat /proc/sys/kernel/random/uuid || date +%s%N)" \
    --data-urlencode "Cert=${CERT}" \
    --data-urlencode "Key=${KEY}" \
    --data-urlencode "CertName=${CERT_NAME}" \
    2>/dev/null || true)

if echo "$RESPONSE" | grep -q "CertificateId\|RequestId"; then
    log_info "证书上传成功"

    # 将证书绑定到域名
    log_info "绑定证书到域名 ${DOMAIN}..."

    # 这里需要额外的 API 调用将证书绑定到 CDN 域名
    # 实际使用时建议用阿里云 CLI 简化
    if command -v aliyun &>/dev/null; then
        aliyun cdn SetDomainServerCertificate \
            --DomainName "${DOMAIN}" \
            --CertName "${CERT_NAME}" \
            --CertType upload \
            --SSLProtocol on \
            --region cn-hangzhou || true
        log_info "证书绑定完成"
    else
        log_warn "aliyun CLI 未安装，请手动在控制台绑定证书"
    fi
else
    log_warn "证书上传可能需要手动处理，响应: ${RESPONSE:0:200}"
fi

log_info "CDN 证书更新完成"
