#!/bin/bash
# ============================================
# 阿里云OSS静态网站部署脚本
# 使用方法: bash deploy-oss.sh
# ============================================

set -e  # 遇到错误立即退出

# ========== 配置区域（请修改以下值）==========
OSS_BUCKET="your-bucket-name"           # OSSBucket名称
OSS_REGION="oss-cn-hangzhou"            # 区域，如oss-cn-hangzhou, oss-cn-shanghai
OSS_ENDPOINT="$OSS_BUCKET.$OSS_REGION.aliyuncs.com"
# ===========================================

echo "=========================================="
echo "  企业门户 - OSS部署脚本"
echo "=========================================="

# Step 1: 构建生产版本
echo ""
echo "[1/3] 构建生产版本..."
npm run generate
if [ $? -ne 0 ]; then
    echo "❌ 构建失败！"
    exit 1
fi
echo "✅ 构建完成"

# Step 2: 确认构建产物
echo ""
echo "[2/3] 检查构建产物..."
if [ ! -d ".output/public" ]; then
    echo "❌ 构建产物不存在于 .output/public"
    exit 1
fi
echo "✅ 构建产物已就绪"

# Step 3: 上传到OSS
echo ""
echo "[3/3] 准备上传到 OSS..."
echo "Bucket: $OSS_BUCKET"
echo "Region: $OSS_REGION"
echo ""
echo "⚠️  请确保已安装 ossutil 或 aliyyun-cli"
echo ""
echo "推荐安装 ossutil:"
echo "  Linux/Mac: curl -o ossutil https://gosspublic.alicdn.com/ossutil/ossutil && chmod +x ossutil"
echo "  Windows: 下载 https://help.aliyun.com/document_detail/209088.html"
echo ""
echo "配置凭证后，执行以下命令手动上传:"
echo "  ossutil cp -r .output/public oss://$OSS_BUCKET/ --force"
echo ""
echo "或使用 aliyun-cli:"
echo "  aliyun oss cp --recursive ./dist oss://$OSS_BUCKET/"
echo ""
echo "=========================================="
echo "  部署完成！"
echo "  访问地址: https://$OSS_ENDPOINT"
echo "=========================================="

# 如果已配置凭证，可以取消下面的注释自动上传
# echo ""
# echo "正在上传到 OSS..."
# ./ossutil cp -r .output/public oss://$OSS_BUCKET/ --force
# if [ $? -eq 0 ]; then
#     echo "✅ 上传成功！"
#     echo "🌐 访问地址: https://$OSS_ENDPOINT"
# else
#     echo "❌ 上传失败，请检查凭证配置"
#     exit 1
# fi
