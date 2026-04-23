<template>
  <div class="min-h-screen">
    <!-- Hero Section -->
    <section class="bg-gradient-to-br from-primary to-secondary py-16 md:py-24">
      <div class="container-base text-center text-white">
        <h1 class="text-3xl md:text-4xl lg:text-5xl font-bold mb-4">联系我们</h1>
        <p class="text-lg md:text-xl text-white/80 max-w-2xl mx-auto">
          专业团队为您解答包装材料相关问题，期待与您的合作
        </p>
      </div>
    </section>

    <!-- Contact Section -->
    <section class="py-16 md:py-24 bg-gray-50">
      <div class="container-base">
        <div class="grid grid-cols-1 lg:grid-cols-2 gap-12">
          <!-- Contact Form -->
          <div class="bg-white rounded-2xl shadow-lg p-8">
            <h2 class="text-2xl font-bold mb-6">在线咨询</h2>
            <ContactForm />
          </div>
          
          <!-- Contact Info -->
          <div class="space-y-8">
            <div class="bg-white rounded-2xl shadow-lg p-8">
              <h2 class="text-2xl font-bold mb-6">联系方式</h2>
              <div class="space-y-4">
                <div class="flex items-start gap-4">
                  <span class="text-2xl">📍</span>
                  <div>
                    <h3 class="font-medium text-gray-900">公司地址</h3>
                    <p class="text-gray-600">广东省珠海市金湾区创业北路20号厂房(三期)2层</p>
                    <p class="text-gray-500 text-sm mt-1">导航搜索"顺泰包装"即可到达</p>
                  </div>
                </div>
                <div class="flex items-start gap-4">
                  <span class="text-2xl">📞</span>
                  <div>
                    <h3 class="font-medium text-gray-900">联系电话</h3>
                    <p class="text-gray-600">400-888-8888（全国统一热线）</p>
                    <p class="text-gray-500 text-sm mt-1">手机: 138-0013-8000（张经理）</p>
                  </div>
                </div>
                <div class="flex items-start gap-4">
                  <span class="text-2xl">✉️</span>
                  <div>
                    <h3 class="font-medium text-gray-900">电子邮箱</h3>
                    <p class="text-gray-600">info@suntaizh.cn</p>
                    <p class="text-gray-500 text-sm mt-1">Sales@suntaizh.cn（销售部）</p>
                  </div>
                </div>
                <div class="flex items-start gap-4">
                  <span class="text-2xl">🕐</span>
                  <div>
                    <h3 class="font-medium text-gray-900">营业时间</h3>
                    <p class="text-gray-600">周一至周六: 8:30-18:00</p>
                    <p class="text-gray-500 text-sm mt-1">周日: 休息</p>
                  </div>
                </div>
              </div>
            </div>

            <!-- QQ & WeChat -->
            <div class="bg-white rounded-2xl shadow-lg p-8">
              <h2 class="text-2xl font-bold mb-6">在线客服</h2>
              <div class="flex flex-wrap gap-4">
                <QqChat />
                <WxQrcode />
              </div>
              <p class="text-gray-500 text-sm mt-4">扫描二维码添加微信/QQ咨询，实时回复</p>
            </div>

            <!-- Map -->
            <div class="bg-white rounded-2xl shadow-lg overflow-hidden">
              <MapEmbed 
                height="350px"
              />
            </div>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<script setup lang="ts">
useHead({
  title: '联系我们 - 珠海市顺泰包装材料有限公司',
  meta: [
    { name: 'description', content: '珠海市顺泰包装材料有限公司联系方式：电话400-888-8888，地址珠海市金湾区创业北路20号。支持在线咨询、包装材料报价、定制服务。' },
    { name: 'keywords', content: '珠海包装材料厂家,顺泰包装联系方式,珠海包装材料电话,珠海包装厂家地址,包装材料报价' },
    { property: 'og:title', content: '联系我们 - 珠海市顺泰包装材料有限公司' },
    { property: 'og:description', content: '联系我们获取包装材料报价、定制服务。电话：400-888-8888，地址：珠海市金湾区' },
    { property: 'og:url', content: 'https://suntaizh.cn/contact' }
  ]
})
</script>
