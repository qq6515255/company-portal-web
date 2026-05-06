#!/bin/bash
# ============================================
# 企业门户 - 自动化部署脚本
# 构建 → ECS部署 → OSS上传 → CDN刷新
# ============================================

set -e  # 遇到错误立即退出

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 项目配置
PROJECT_NAME="company-portal"
PROJECT_DIR="/var/www/${PROJECT_NAME}"

# ========== 加载环境变量 ==========
if [ -f .env ]; then
    echo -e "${YELLOW}加载 .env 配置...${NC}"
    export $(grep -v '^#' .env | xargs)
else
    echo -e "${RED}❌ .env 文件不存在${NC}"
    exit 1
fi

# ========== 函数定义 ==========
log_info() { echo -e "${GREEN}ℹ️  $1${NC}"; }
log_warn() { echo -e "${YELLOW}⚠️  $1${NC}"; }
log_error() { echo -e "${RED}❌ $1${NC}"; }

# 等待用户确认
confirm() {
    read -p "$1 (y/n): " -n 1 -r
    echo
    [[ $REPLY =~ ^[Yy]$ ]]
}

# ========== 步骤1: 构建 ==========
build_project() {
    log_info "========== [1/4] 构建生产版本 =========="
    
    # 安装依赖
    log_info "安装依赖..."
    npm install
    
    # 构建
    log_info "执行构建..."
    npm run generate
    
    if [ $? -ne 0 ]; then
        log_error "构建失败！"
        exit 1
    fi
    
    # 检查构建产物
    if [ ! -d ".output/public" ]; then
        log_error "构建产物不存在！"
        exit 1
    fi
    
    log_info "✅ 构建完成"
}

# ========== 步骤2: 部署到ECS ==========
deploy_to_ecs() {
    log_info "========== [2/4] 部署到 ECS =========="
    
    # 检查ECS配置
    if [ -z "$ECS_HOST" ] || [ -z "$ECS_USER" ] || [ -z "$ECS_PASSWORD" ]; then
        log_warn "ECS配置不完整，跳过ECS部署"
        return 0
    fi
    
    log_info "连接 ECS: ${ECS_USER}@${ECS_HOST}"
    
    # 创建远程目录
    log_info "创建远程目录..."
    sshpass -p "$ECS_PASSWORD" ssh -o StrictHostKeyChecking=no ${ECS_USER}@${ECS_HOST} "
        sudo mkdir -p ${PROJECT_DIR}
        sudo chown -R ${ECS_USER}:${ECS_USER} ${PROJECT_DIR}
    "
    
    # 同步文件到ECS
    log_info "同步文件到 ECS..."
    sshpass -p "$ECS_PASSWORD" rsync -avz --delete \
        -e "ssh -o StrictHostKeyChecking=no" \
        .output/public/ \
        ${ECS_USER}@${ECS_HOST}:${PROJECT_DIR}/ \
        --exclude='.DS_Store' \
        --exclude='Thumbs.db'
    
    # 设置权限
    sshpass -p "$ECS_PASSWORD" ssh -o StrictHostKeyChecking=no ${ECS_USER}@${ECS_HOST} "
        sudo chown -R www-data:www-data ${PROJECT_DIR}
    "
    
    log_info "✅ ECS部署完成"
    log_info "📂 路径: ${ECS_USER}@${ECS_HOST}:${PROJECT_DIR}"
}

# ========== 步骤3: 上传到OSS ==========
upload_to_oss() {
    log_info "========== [3/4] 上传到 OSS =========="
    
    # 检查OSS配置
    if [ -z "$OSS_BUCKET" ] || [ -z "$OSS_ACCESS_KEY_ID" ] || [ -z "$OSS_ACCESS_KEY_SECRET" ]; then
        log_warn "OSS配置不完整，跳过OSS上传"
        return 0
    fi
    
    log_info "Bucket: ${OSS_BUCKET}"
    log_info "Region: ${OSS_REGION:-oss-cn-hangzhou}"
    
    # 使用阿里云CLI上传
    log_info "使用 ossutil 上传..."
    
    # 配置 ossutil
    ossutil config -i ${OSS_ACCESS_KEY_ID} -k ${OSS_ACCESS_KEY_SECRET} -e ${OSS_REGION:-oss-cn-hangzhou}.aliyuncs.com
    
    # 上传文件
    ossutil cp -r .output/public/ oss://${OSS_BUCKET}/ --force --retry-times=3
    
    if [ $? -eq 0 ]; then
        log_info "✅ OSS上传成功"
        log_info "📂 Bucket: oss://${OSS_BUCKET}/"
    else
        log_error "OSS上传失败！"
        exit 1
    fi
}

# ========== 步骤4: 刷新CDN ==========
refresh_cdn() {
    log_info "========== [4/4] 刷新 CDN =========="
    
    # 检查CDN配置
    if [ -z "$CDN_DOMAIN" ] || [ -z "$OSS_ACCESS_KEY_ID" ] || [ -z "$OSS_ACCESS_KEY_SECRET" ]; then
        log_warn "CDN配置不完整，跳过CDN刷新"
        return 0
    fi
    
    log_info "刷新域名: ${CDN_DOMAIN}"
    
    # 使用阿里云CLI刷新CDN
    aliyun alidns DescribeDomainRecords --help > /dev/null 2>&1 || log_warn "aliyun CLI 未安装，跳过CDN刷新"
    
    # 调用CDN刷新接口
    RESULT=$(aliyun cdn PushObjectCache \
        --ObjectPath ${CDN_DOMAIN}/ \
        --ObjectType directory \
        --Area mainland \
        2>&1)
    
    if echo "$RESULT" | grep -q "RequestId"; then
        log_info "✅ CDN刷新成功"
    else
        log_warn "CDN刷新可能失败: $RESULT"
    fi
}

# ========== 主流程 ==========
main() {
    echo ""
    echo -e "${GREEN}==========================================${NC}"
    echo -e "${GREEN}  企业门户 - 自动化部署脚本${NC}"
    echo -e "${GREEN}==========================================${NC}"
    echo ""
    echo "项目: ${SITE_NAME:-珠海市顺泰包装材料有限公司}"
    echo "URL:  ${SITE_URL:-https://suntaizh.cn}"
    echo ""
    
    # 显示配置
    log_info "配置检查:"
    [ -n "$ECS_HOST" ] && log_info "  ✅ ECS: ${ECS_USER}@${ECS_HOST}" || log_warn "  ⚠️  ECS: 未配置"
    [ -n "$OSS_BUCKET" ] && log_info "  ✅ OSS: ${OSS_BUCKET}" || log_warn "  ⚠️  OSS: 未配置"
    [ -n "$CDN_DOMAIN" ] && log_info "  ✅ CDN: ${CDN_DOMAIN}" || log_warn "  ⚠️  CDN: 未配置"
    echo ""
    
    # 确认执行
    if ! confirm "是否开始部署？"; then
        echo "已取消部署"
        exit 0
    fi
    
    # 执行部署步骤
    echo ""
    build_project
    echo ""
    deploy_to_ecs
    echo ""
    upload_to_oss
    echo ""
    refresh_cdn
    
    # 完成
    echo ""
    echo -e "${GREEN}==========================================${NC}"
    echo -e "${GREEN}  ✅ 部署完成！${NC}"
    echo -e "${GREEN}==========================================${NC}"
    echo ""
    [ -n "$SITE_URL" ] && log_info "🌐 访问地址: ${SITE_URL}"
    echo ""
}

# ========== 命令行参数处理 ==========
case "${1:-}" in
    --build-only)
        build_project
        ;;
    --ecs-only)
        deploy_to_ecs
        ;;
    --oss-only)
        upload_to_oss
        ;;
    --cdn-only)
        refresh_cdn
        ;;
    *)
        main
        ;;
esac
