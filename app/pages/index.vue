<template>
  <div class="min-h-screen">
    <!-- JSON-LD Structured Data -->
    <Head>
      <Script type="application/ld+json" v-html="organizationSchema" />
      <Script type="application/ld+json" v-html="localBusinessSchema" />
    </Head>

    <!-- Hero Section -->
    <section class="relative bg-gradient-to-r from-primary to-blue-600 text-white py-24 md:py-32">
      <div class="container-base text-center">
        <h1 class="text-4xl md:text-5xl lg:text-6xl font-bold mb-6">
          珠海包装材料厂家_专业珍珠棉_透明胶_双面胶_打包带
        </h1>
        <p class="text-xl md:text-2xl text-white/90 mb-10 max-w-3xl mx-auto">
          珠海市顺泰包装材料有限公司 - 15年专业生产珍珠棉、泡沫棉、透明胶、双面胶、海绵胶、打包带、保护膜、制袋等包装材料，厂家直销，品质保障
        </p>
        <div class="flex flex-wrap justify-center gap-4">
          <NuxtLink to="/products" class="btn bg-white text-primary px-8 py-3 rounded-lg font-medium hover:bg-gray-100 transition">
            查看产品
          </NuxtLink>
          <NuxtLink to="/contact" class="btn bg-primary/20 border-2 border-white px-8 py-3 rounded-lg font-medium hover:bg-white/10 transition">
            立即咨询
          </NuxtLink>
        </div>
      </div>
    </section>

    <!-- Products Overview Section -->
    <section class="py-16 md:py-24 bg-gray-50">
      <div class="container-base">
        <div class="text-center mb-12">
          <h2 class="text-3xl md:text-4xl font-bold text-gray-900 mb-4">包装材料产品中心</h2>
          <p class="text-gray-600 max-w-xl mx-auto">专业生产各类包装材料，满足珠三角企业多样化需求</p>
        </div>
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
          <NuxtLink to="/products" class="group bg-white rounded-xl shadow-sm hover:shadow-lg transition p-6">
            <div class="bg-gray-200 border-2 border-dashed rounded-xl w-full h-40 mb-4 flex-center">
              <span class="text-gray-400 text-lg">产品图片</span>
            </div>
            <h3 class="text-xl font-bold text-gray-900 mb-2 group-hover:text-primary transition">珍珠棉/泡沫棉</h3>
            <p class="text-gray-600 mb-4 text-sm">缓冲防震包装材料，适用于电子、家具、玻璃等产品的防护包装</p>
            <span class="text-primary font-medium group-hover:underline">查看详情 →</span>
          </NuxtLink>
          <NuxtLink to="/products" class="group bg-white rounded-xl shadow-sm hover:shadow-lg transition p-6">
            <div class="bg-gray-200 border-2 border-dashed rounded-xl w-full h-40 mb-4 flex-center">
              <span class="text-gray-400 text-lg">产品图片</span>
            </div>
            <h3 class="text-xl font-bold text-gray-900 mb-2 group-hover:text-primary transition">透明胶/双面胶</h3>
            <p class="text-gray-600 mb-4 text-sm">工业级胶带，粘性强、不残胶，适用于包装、固定、密封等多种用途</p>
            <span class="text-primary font-medium group-hover:underline">查看详情 →</span>
          </NuxtLink>
          <NuxtLink to="/products" class="group bg-white rounded-xl shadow-sm hover:shadow-lg transition p-6">
            <div class="bg-gray-200 border-2 border-dashed rounded-xl w-full h-40 mb-4 flex-center">
              <span class="text-gray-400 text-lg">产品图片</span>
            </div>
            <h3 class="text-xl font-bold text-gray-900 mb-2 group-hover:text-primary transition">海绵胶/保护膜</h3>
            <p class="text-gray-600 mb-4 text-sm">高密度海绵胶，柔韧防震；PE保护膜，表面防护专家</p>
            <span class="text-primary font-medium group-hover:underline">查看详情 →</span>
          </NuxtLink>
          <NuxtLink to="/products" class="group bg-white rounded-xl shadow-sm hover:shadow-lg transition p-6">
            <div class="bg-gray-200 border-2 border-dashed rounded-xl w-full h-40 mb-4 flex-center">
              <span class="text-gray-400 text-lg">产品图片</span>
            </div>
            <h3 class="text-xl font-bold text-gray-900 mb-2 group-hover:text-primary transition">打包带/制袋</h3>
            <p class="text-gray-600 mb-4 text-sm">PP/PET打包带，韧性强；自立袋、复合袋等定制制袋服务</p>
            <span class="text-primary font-medium group-hover:underline">查看详情 →</span>
          </NuxtLink>
        </div>
      </div>
    </section>

    <!-- Advantages Section -->
    <section class="py-16 md:py-24">
      <div class="container-base">
        <div class="text-center mb-12">
          <h2 class="text-3xl md:text-4xl font-bold text-gray-900 mb-4">为什么选择顺泰包装</h2>
          <p class="text-gray-600">15年专业包装材料厂家，珠三角1000+企业的共同选择</p>
        </div>
        <div class="grid grid-cols-2 lg:grid-cols-4 gap-6">
          <div class="text-center p-6">
            <div class="text-5xl mb-4">🏭</div>
            <h3 class="text-xl font-bold text-gray-900 mb-2">厂家直销</h3>
            <p class="text-gray-600 text-sm">自有工厂，无中间商赚差价，价格更优惠</p>
          </div>
          <div class="text-center p-6">
            <div class="text-5xl mb-4">📦</div>
            <h3 class="text-xl font-bold text-gray-900 mb-2">品种齐全</h3>
            <p class="text-gray-600 text-sm">珍珠棉、胶带、海绵、打包带等全系列包装材料</p>
          </div>
          <div class="text-center p-6">
            <div class="text-5xl mb-4">🚚</div>
            <h3 class="text-xl font-bold text-gray-900 mb-2">交货准时</h3>
            <p class="text-gray-600 text-sm">珠海、中山、江门等珠三角地区免费送货</p>
          </div>
          <div class="text-center p-6">
            <div class="text-5xl mb-4">🔧</div>
            <h3 class="text-xl font-bold text-gray-900 mb-2">定制服务</h3>
            <p class="text-gray-600 text-sm">根据客户需求定制各种规格尺寸的包装材料</p>
          </div>
        </div>
      </div>
    </section>

    <!-- 企业简介 Section -->
    <section class="py-16 md:py-24 bg-white">
      <div class="container-base">
        <h2 class="text-2xl md:text-3xl font-bold text-center mb-12">关于珠海市顺泰包装材料有限公司</h2>
        <div class="grid grid-cols-1 lg:grid-cols-2 gap-8 lg:gap-12 items-center">
          <!-- Image Placeholder -->
          <div>
            <div class="bg-gray-200 border-2 border-dashed rounded-xl w-full h-64 md:h-80 lg:h-96 flex-center">
              <span class="text-gray-400 text-lg">企业图片</span>
            </div>
          </div>
          <!-- Text Content -->
          <div>
            <p class="text-gray-600 leading-relaxed">
              <strong>珠海市顺泰包装材料有限公司</strong>成立于2010年，是一家专注于包装材料研发、生产、销售的现代化企业。
              位于珠海市金湾区，专业生产<strong>珍珠棉、泡沫棉、透明胶、双面胶、海绵胶、打包带、保护膜，制袋</strong>等各类包装材料。
            </p>
            <p class="text-gray-600 leading-relaxed mt-4">
              公司拥有标准化的生产车间和完善的检测设备，产品广泛应用于电子、家具、建材、食品、医药等行业。
              我们秉承"质量第一、诚信经营"的理念，为珠三角地区的企业提供优质的包装材料和解决方案。
            </p>
            <div class="flex flex-wrap gap-4 mt-8">
              <div class="text-center px-6 py-4 bg-gray-50 rounded-lg flex-1 min-w-24">
                <div class="text-2xl md:text-3xl font-bold text-primary">1000+</div>
                <div class="text-gray-500 text-sm mt-1">服务企业</div>
              </div>
              <div class="text-center px-6 py-4 bg-gray-50 rounded-lg flex-1 min-w-24">
                <div class="text-2xl md:text-3xl font-bold text-primary">15</div>
                <div class="text-gray-500 text-sm mt-1">年行业经验</div>
              </div>
              <div class="text-center px-6 py-4 bg-gray-50 rounded-lg flex-1 min-w-24">
                <div class="text-2xl md:text-3xl font-bold text-primary">50+</div>
                <div class="text-gray-500 text-sm mt-1">种产品</div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- 联系我们 Section -->
    <section class="py-16 md:py-20 bg-gray-50">
      <div class="container-base">
        <div class="text-center mb-12">
          <h2 class="text-3xl md:text-4xl font-bold text-gray-900 mb-4">联系我们</h2>
          <p class="text-gray-600">专业团队，随时为您解答包装材料相关问题</p>
        </div>
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
          <div class="bg-white rounded-xl shadow-sm p-6 text-center">
            <span class="text-4xl mb-4 block">📍</span>
            <h3 class="font-semibold text-gray-900 mb-2">公司地址</h3>
            <p class="text-gray-600 text-sm">广东省珠海市金湾区创业北路20号厂房(三期)2层</p>
          </div>
          <div class="bg-white rounded-xl shadow-sm p-6 text-center">
            <span class="text-4xl mb-4 block">📞</span>
            <h3 class="font-semibold text-gray-900 mb-2">联系电话</h3>
            <p class="text-gray-600 text-sm">400-888-8888</p>
          </div>
          <div class="bg-white rounded-xl shadow-sm p-6 text-center">
            <span class="text-4xl mb-4 block">✉️</span>
            <h3 class="font-semibold text-gray-900 mb-2">电子邮箱</h3>
            <p class="text-gray-600 text-sm">info@suntaizh.cn</p>
          </div>
          <div class="bg-white rounded-xl shadow-sm p-6 text-center">
            <span class="text-4xl mb-4 block">🕐</span>
            <h3 class="font-semibold text-gray-900 mb-2">营业时间</h3>
            <p class="text-gray-600 text-sm">周一至周六 8:30-18:00</p>
          </div>
        </div>
        <!-- 地图 -->
        <div class="bg-white rounded-xl shadow-sm overflow-hidden">
          <MapEmbed height="400px" />
        </div>
        <div class="text-center mt-10">
          <NuxtLink to="/contact" class="btn bg-primary text-white px-8 py-3 rounded-lg font-medium hover:bg-primary/90 transition">
            在线咨询
          </NuxtLink>
        </div>
      </div>
    </section>

    <!-- CTA Section -->
    <section class="py-16 md:py-20 bg-gray-900 text-white">
      <div class="container-base text-center">
        <h2 class="text-3xl md:text-4xl font-bold mb-4">一站式包装材料解决方案</h2>
        <p class="text-gray-300 mb-8">从咨询到售后，我们全程为您提供专业的包装材料服务</p>
        <NuxtLink to="/contact" class="btn bg-primary text-white px-8 py-3 rounded-lg font-medium hover:bg-primary/90 transition">
          立即咨询
        </NuxtLink>
      </div>
    </section>
  </div>
</template>

<script setup lang="ts">
// SEO Structured Data
const organizationSchema = computed(() => JSON.stringify({
  "@context": "https://schema.org",
  "@type": "Organization",
  "name": "珠海市顺泰包装材料有限公司",
  "alternateName": "顺泰包装",
  "url": "https://suntaizh.cn",
  "logo": "https://suntaizh.cn/favicon.ico",
  "description": "专业生产珍珠棉、泡沫棉、透明胶、双面胶、海绵胶、打包带、保护膜、制袋等包装材料，厂家直销",
  "areaServed": {
    "@type": "Place",
    "name": "广东省珠海市"
  },
  "contactPoint": {
    "@type": "ContactPoint",
    "telephone": "400-888-8888",
    "contactType": "customer service",
    "availableLanguage": ["Chinese", "Mandarin"]
  }
}))

const localBusinessSchema = computed(() => JSON.stringify({
  "@context": "https://schema.org",
  "@type": "LocalBusiness",
  "name": "珠海市顺泰包装材料有限公司",
  "image": "https://suntaizh.cn/images/logo.png",
  "url": "https://suntaizh.cn",
  "telephone": "400-888-8888",
  "email": "info@suntaizh.cn",
  "address": {
    "@type": "PostalAddress",
    "streetAddress": "创业北路20号厂房(三期)2层",
    "addressLocality": "金湾区",
    "addressRegion": "珠海市",
    "postalCode": "519000",
    "addressCountry": "CN"
  },
  "geo": {
    "@type": "GeoCoordinates",
    "latitude": 22.07,
    "longitude": 113.40
  },
  "openingHoursSpecification": {
    "@type": "OpeningHoursSpecification",
    "dayOfWeek": ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"],
    "opens": "08:30",
    "closes": "18:00"
  },
  "priceRange": "$$",
  "aggregateRating": {
    "@type": "AggregateRating",
    "ratingValue": "4.8",
    "reviewCount": "126"
  }
}))

useHead({
  title: '珠海包装材料厂家_专业生产珍珠棉_透明胶_打包带_保护膜-顺泰包装',
  meta: [
    { name: 'description', content: '珠海市顺泰包装材料有限公司专业生产珍珠棉、泡沫棉、透明胶、双面胶、海绵胶、打包带、保护膜、制袋等包装材料，15年行业经验，厂家直销，价格优惠，服务珠海、中山、江门等珠三角地区。' },
    { name: 'keywords', content: '珠海包装材料,珍珠棉厂家,泡沫棉,透明胶,双面胶,海绵胶,打包带,保护膜,制袋,珠海包装厂家,中山包装材料,江门包装' },
    { property: 'og:title', content: '珠海市顺泰包装材料有限公司 - 专业包装材料生产厂家' },
    { property: 'og:description', content: '专业生产珍珠棉、泡沫棉、透明胶、双面胶、海绵胶、打包带、保护膜、制袋等包装材料，厂家直销，品质保障' },
    { property: 'og:url', content: 'https://suntaizh.cn/' },
    { property: 'og:type', content: 'website' }
  ]
})
</script>
