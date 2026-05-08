#!/bin/bash
# ============================================
# 顺泰包装 - 本地部署脚本 (OSS + CDN)
# 构建 → 上传阿里云 OSS → 刷新 CDN
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

# ========== 读取配置 ==========
if [ -f .env ]; then
    export $(grep -v '^#' .env | xargs)
fi

BUCKET="${OSS_BUCKET:-}"
REGION="${OSS_REGION:-oss-cn-hangzhou}"
ENDPOINT="${OSS_ENDPOINT:-${BUCKET}.${REGION}.aliyuncs.com}"
CDN_DOMAIN="${CDN_DOMAIN:-}"
OSS_PREFIX="${OSS_PREFIX:-company-portal}"
ACCESS_KEY_ID="${ALIYUN_ACCESS_KEY_ID:-${OSS_ACCESS_KEY_ID:-}}"
ACCESS_KEY_SECRET="${ALIYUN_ACCESS_KEY_SECRET:-${OSS_ACCESS_KEY_SECRET:-}}"

# 检查必要配置
if [ -z "$BUCKET" ] || [ -z "$ACCESS_KEY_ID" ] || [ -z "$ACCESS_KEY_SECRET" ]; then
    log_error "缺少 OSS 配置，请检查 .env 文件："
    echo "  OSS_BUCKET=your-bucket"
    echo "  ALIYUN_ACCESS_KEY_ID=your-key"
    echo "  ALIYUN_ACCESS_KEY_SECRET=your-secret"
    exit 1
fi

OSS_PREFIX="${OSS_PREFIX#/}"
OSS_PREFIX="${OSS_PREFIX%/}"
OSS_BASE="oss://${BUCKET}"
if [ -n "$OSS_PREFIX" ]; then
    OSS_BASE="${OSS_BASE}/${OSS_PREFIX}"
fi

# ========== Step 1: 构建 ==========
log_step "[1/4] 构建静态站点"

rm -rf .output

if command -v pnpm &> /dev/null; then
    pnpm install --frozen-lockfile
    NUXT_APP_CDN_URL="${NUXT_APP_CDN_URL:-}" pnpm generate
else
    npm ci
    NUXT_APP_CDN_URL="${NUXT_APP_CDN_URL:-}" npm run generate
fi

if [ ! -d ".output/public" ]; then
    log_error "构建失败！"
    exit 1
fi

BUILD_SIZE=$(du -sh ".output/public" | cut -f1)
log_info "构建完成: ${BUILD_SIZE}"

# ========== Step 2: 预压缩 ==========
log_step "[2/4] 预压缩静态资源"

find .output/public -type f \( \
    -name "*.js" -o -name "*.css" -o -name "*.html" -o \
    -name "*.json" -o -name "*.xml" -o -name "*.svg" -o \
    -name "*.txt" \
\) -exec gzip -kf9 {} \;

if command -v brotli &> /dev/null; then
    find .output/public -type f \( \
        -name "*.js" -o -name "*.css" -o -name "*.html" -o \
        -name "*.json" -o -name "*.xml" -o -name "*.svg" -o \
        -name "*.txt" \
    \) -exec brotli -kfZ {} \;
    log_info "Brotli 压缩完成"
fi

# ========== Step 3: 安装/检查 ossutil ==========
log_step "[3/4] 上传 OSS"

OSSUTIL="./ossutil"
if [ ! -f "$OSSUTIL" ]; then
    log_info "下载 ossutil..."
    curl -sL -o ossutil.zip "https://gosspublic.alicdn.com/ossutil/v2/2.2.2/ossutil-2.2.2-linux-amd64.zip"
    unzip -q ossutil.zip
    mv ossutil-2.2.2-linux-amd64/ossutil ./ossutil
    chmod +x ossutil
fi

# 配置并上传
$OSSUTIL config -e "$ENDPOINT" --region "${ALIYUN_REGION:-${REGION#oss-}}" -i "$ACCESS_KEY_ID" -k "$ACCESS_KEY_SECRET" --loglevel error

log_info "上传到 ${OSS_BASE}/ ..."
$OSSUTIL cp -r -f \
    --acl public-read \
    --jobs 10 \
    .output/public/ \
    "${OSS_BASE}/"

log_info "OSS 上传完成"

# ========== Step 4: 刷新 CDN ==========
log_step "[4/4] 刷新 CDN"

if [ -n "$CDN_DOMAIN" ]; then
    log_info "刷新 CDN: ${CDN_DOMAIN}"

    # 检查 aliyun CLI
    if ! command -v aliyun &> /dev/null; then
        log_warn "aliyun CLI 未安装，跳过 CDN 刷新"
        log_info "安装方式: brew install aliyun-cli"
    else
        aliyun configure set --profile default --mode AK \
            --access-key-id "$ACCESS_KEY_ID" \
            --access-key-secret "$ACCESS_KEY_SECRET" \
            --region cn-hangzhou

        CDN_TARGET="https://${CDN_DOMAIN}/"
        if [ -n "$OSS_PREFIX" ]; then
            CDN_TARGET="${CDN_TARGET}${OSS_PREFIX}/"
        fi

        aliyun cdn PushObjectCache \
            --ObjectPath "${CDN_TARGET}" \
            --ObjectType Directory || true

        log_info "CDN 刷新已提交"
    fi
else
    log_warn "未配置 CDN_DOMAIN，跳过 CDN 刷新"
fi

# ========== 完成 ==========
echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}  ✅ 部署完成！${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo -e "  站点:   https://${CDN_DOMAIN:-${ENDPOINT}}"
echo -e "  OSS:    ${OSS_BASE}/"
echo -e "  大小:   ${BUILD_SIZE}"
echo ""

# 可选：测速
if command -v curl &> /dev/null && [ -n "$CDN_DOMAIN" ]; then
    log_info "测试首页..."
    TARGET_URL="https://${CDN_DOMAIN}/"
    if [ -n "$OSS_PREFIX" ]; then
        TARGET_URL="${TARGET_URL}${OSS_PREFIX}/"
    fi
    HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" "${TARGET_URL}" || echo "000")
    if [ "$HTTP_CODE" = "200" ]; then
        log_info "首页正常 (HTTP 200)"
    else
        log_warn "首页异常 (HTTP ${HTTP_CODE})，CDN 可能还在预热"
    fi
fi

echo ""
