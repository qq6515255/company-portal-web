<template>
  <div class="min-h-screen bg-[#ECFDF5] text-[#064E3B] font-sans selection:bg-[#F97316] selection:text-white">
    <!-- Hero Section (Factory Video Background) -->
    <section class="relative min-h-screen flex items-center justify-center overflow-hidden bg-[#064E3B]">
      <!-- Background Video with Overlay -->
      <div class="absolute inset-0 z-0">
        <!-- Temporary placeholder video. Replace with your actual factory/production line video -->
        <video
          autoplay
          loop
          muted
          playsinline
          class="w-full h-full object-cover object-center opacity-50 mix-blend-luminosity"
          :poster="publicAsset('/images/products/hero-factory.jpg')"
        >
          <!-- Using a sample stock video of an industrial machine/factory process -->
          <source src="https://cdn.pixabay.com/video/2019/04/10/22699-330456185_large.mp4" type="video/mp4" />
        </video>
        <div class="absolute inset-0 bg-gradient-to-r from-[#064E3B]/90 via-[#064E3B]/60 to-[#064E3B]/40"></div>
        <div class="absolute inset-0 opacity-10 bg-[url('https://www.transparenttextures.com/patterns/cubes.png')]"></div>
      </div>

      <!-- Creative UI: Industrial Tape Animation -->
      <div class="absolute bottom-48 -right-24 w-[135%] max-w-6xl h-24 bg-[#F97316]/90 backdrop-blur-md z-20 animate-tape-seal-right origin-right border-y border-white/30 shadow-[0_10px_30px_rgba(249,115,22,0.3)] flex items-center overflow-hidden mix-blend-overlay transform -rotate-45">
        <div class="animate-marquee whitespace-nowrap text-white font-heading font-black tracking-[0.3em] uppercase text-4xl flex items-center gap-8">
          <span><span class="i-carbon-warning-alt mr-2"></span>STRONG ADHESION</span>
          <span><span class="i-carbon-warning-alt mr-2"></span>INDUSTRIAL TAPE</span>
          <span><span class="i-carbon-warning-alt mr-2"></span>SUNTAI PACKAGING</span>
          <span><span class="i-carbon-warning-alt mr-2"></span>MAXIMUM SECURITY</span>
          <span><span class="i-carbon-warning-alt mr-2"></span>STRONG ADHESION</span>
          <span><span class="i-carbon-warning-alt mr-2"></span>INDUSTRIAL TAPE</span>
          <span><span class="i-carbon-warning-alt mr-2"></span>SUNTAI PACKAGING</span>
          <span><span class="i-carbon-warning-alt mr-2"></span>MAXIMUM SECURITY</span>
        </div>
      </div>

      <div class="container-base relative z-10 pt-32 pb-20">
        <div class="max-w-4xl">
          <div class="inline-flex items-center gap-2 px-4 py-2 mb-8 bg-[#059669]/30 backdrop-blur-md border border-[#10B981]/50 text-white font-medium tracking-widest text-sm rounded-sm uppercase">
            <span class="w-2 h-2 rounded-full bg-[#F97316] animate-pulse"></span>
            15年源头实力工厂
          </div>
          <h1 class="text-5xl md:text-7xl lg:text-[80px] font-heading font-bold leading-tight text-white mb-8 tracking-tight">
            打造工业级<br/>
            <span class="text-[#10B981]">包装防护体系</span>
          </h1>
          <p class="text-xl md:text-2xl text-emerald-100 mb-12 max-w-2xl font-light tracking-wide leading-relaxed">
            专业生产珍珠棉、泡沫棉、透明胶、双面胶、海绵胶、打包带、保护膜、制袋。从源头把控品质，为您提供极具性价比的包装解决方案。
          </p>
          <div class="flex flex-col sm:flex-row items-start gap-4">
            <NuxtLink to="/products" class="btn-peel px-10 py-4 bg-[#F97316] text-white font-heading font-semibold tracking-wider text-lg uppercase hover:bg-[#ea580c] transition-all duration-300 w-full sm:w-auto text-center shadow-lg flex items-center justify-center gap-2 group relative overflow-hidden">
              探索产品矩阵
              <span class="i-carbon-arrow-right text-xl group-hover:translate-x-1 transition-transform"></span>
            </NuxtLink>
            <a href="#location" class="btn-peel px-10 py-4 bg-white/10 backdrop-blur-md border border-white/20 text-white font-heading font-medium tracking-wider text-lg uppercase hover:bg-white/20 transition-all duration-300 w-full sm:w-auto text-center flex items-center justify-center gap-2 relative overflow-hidden">
              <span class="i-carbon-location text-xl"></span>
              参观工厂
            </a>
          </div>
        </div>
      </div>
    </section>

    <!-- Products Overview ("Industrial Product Matrix") -->
    <section class="py-24 bg-white relative">
      <div class="container-base relative z-10">
        <div class="text-center mb-16">
          <div class="inline-block px-4 py-1.5 mb-4 bg-[#059669]/10 text-[#059669] font-semibold tracking-wider text-sm rounded-sm uppercase">核心产品线</div>
          <h2 class="text-4xl md:text-5xl font-heading font-bold text-[#064E3B] mb-6">全品类<span class="text-[#10B981]">包装材料</span>供应</h2>
          <p class="text-[#064E3B]/70 text-lg max-w-2xl mx-auto">高强度、高韧性，满足电子、五金、家具等各行业的极限防护挑战。</p>
        </div>
        
        <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
          <!-- Card 1 -->
          <NuxtLink to="/products" class="group flex flex-col sm:flex-row overflow-hidden bg-[#ECFDF5] rounded-lg shadow-sm border border-[#10B981]/20 transition-all duration-300 hover:shadow-xl hover:-translate-y-2 relative">
            <div class="w-full sm:w-2/5 bg-[#064E3B] relative overflow-hidden flex items-center justify-center">
              <img :src="publicAsset('/images/products/pearl-cotton.jpg')" alt="珍珠棉/泡沫棉" class="w-full h-full object-cover opacity-80 group-hover:opacity-100 group-hover:scale-110 transition-all duration-500" />
            </div>
            <div class="p-8 w-full sm:w-3/5 flex flex-col justify-center relative z-20">
              <h3 class="text-2xl font-heading font-bold text-[#064E3B] mb-3">珍珠棉 / 泡沫棉</h3>
              <p class="text-[#064E3B]/70 mb-6 leading-relaxed">极致缓冲防震，适用于电子、家具、玻璃等高价值产品的防护包装。</p>
              <div class="mt-auto flex items-center text-[#F97316] font-semibold text-sm uppercase tracking-wider">
                了解详情 <span class="i-carbon-arrow-right ml-2 text-lg group-hover:translate-x-2 transition-transform duration-300"></span>
              </div>
            </div>
          </NuxtLink>
          
          <!-- Card 2 -->
          <NuxtLink to="/products" class="group flex flex-col sm:flex-row overflow-hidden bg-[#ECFDF5] rounded-lg shadow-sm border border-[#10B981]/20 transition-all duration-300 hover:shadow-xl hover:-translate-y-2 relative">
            <div class="w-full sm:w-2/5 bg-[#064E3B] relative overflow-hidden flex items-center justify-center">
              <img :src="publicAsset('/images/products/adhesive-tape.jpg')" alt="透明胶/双面胶" class="w-full h-full object-cover opacity-80 group-hover:opacity-100 group-hover:scale-110 transition-all duration-500" />
            </div>
            <div class="p-8 w-full sm:w-3/5 flex flex-col justify-center relative z-20">
              <h3 class="text-2xl font-heading font-bold text-[#064E3B] mb-3">透明胶 / 双面胶</h3>
              <p class="text-[#064E3B]/70 mb-6 leading-relaxed">工业级强力胶带，持久粘性不残胶，应对各种严苛密封与固定需求。</p>
              <div class="mt-auto flex items-center text-[#F97316] font-semibold text-sm uppercase tracking-wider">
                了解详情 <span class="i-carbon-arrow-right ml-2 text-lg group-hover:translate-x-2 transition-transform duration-300"></span>
              </div>
            </div>
          </NuxtLink>
          
          <!-- Card 3 -->
          <NuxtLink to="/products" class="group flex flex-col sm:flex-row overflow-hidden bg-[#ECFDF5] rounded-lg shadow-sm border border-[#10B981]/20 transition-all duration-300 hover:shadow-xl hover:-translate-y-2 relative">
            <div class="w-full sm:w-2/5 bg-[#064E3B] relative overflow-hidden flex items-center justify-center">
              <img :src="publicAsset('/images/products/pe-protective-film.jpg')" alt="海绵胶/保护膜" class="w-full h-full object-cover object-center scale-[1.2] group-hover:scale-[1.28] transition-transform duration-500" />
            </div>
            <div class="p-8 w-full sm:w-3/5 flex flex-col justify-center relative z-20">
              <h3 class="text-2xl font-heading font-bold text-[#064E3B] mb-3">海绵胶 / 保护膜</h3>
              <p class="text-[#064E3B]/70 mb-6 leading-relaxed">高密度海绵胶柔韧抗震；PE保护膜化身表面防护盾牌。</p>
              <div class="mt-auto flex items-center text-[#F97316] font-semibold text-sm uppercase tracking-wider">
                了解详情 <span class="i-carbon-arrow-right ml-2 text-lg group-hover:translate-x-2 transition-transform duration-300"></span>
              </div>
            </div>
          </NuxtLink>
          
          <!-- Card 4 -->
          <NuxtLink to="/products" class="group flex flex-col sm:flex-row overflow-hidden bg-[#ECFDF5] rounded-lg shadow-sm border border-[#10B981]/20 transition-all duration-300 hover:shadow-xl hover:-translate-y-2 relative">
            <div class="w-full sm:w-2/5 bg-[#064E3B] relative overflow-hidden flex items-center justify-center">
              <img :src="publicAsset('/images/products/strapping-bags-generated.png')" alt="打包带/定制制袋" class="w-full h-full object-cover object-center scale-110 group-hover:scale-[1.16] transition-transform duration-500" />
            </div>
            <div class="p-8 w-full sm:w-3/5 flex flex-col justify-center relative z-20">
              <h3 class="text-2xl font-heading font-bold text-[#064E3B] mb-3">打包带 / 定制制袋</h3>
              <p class="text-[#064E3B]/70 mb-6 leading-relaxed">高韧性PP/PET打包带，极限拉力。自立袋、复合袋等硬核定制。</p>
              <div class="mt-auto flex items-center text-[#F97316] font-semibold text-sm uppercase tracking-wider">
                了解详情 <span class="i-carbon-arrow-right ml-2 text-lg group-hover:translate-x-2 transition-transform duration-300"></span>
              </div>
            </div>
          </NuxtLink>
        </div>
      </div>
    </section>

    <!-- Location & Contact Info ("Corporate Location") -->
    <section id="location" class="py-24 bg-[#ECFDF5] relative">
      <div class="container-base relative z-10">
        <div class="grid grid-cols-1 lg:grid-cols-2 gap-12 lg:gap-20 items-center">
          <div class="order-2 lg:order-1 bg-white p-2 rounded-xl shadow-lg border border-[#10B981]/20 overflow-hidden relative group h-[320px] md:h-[400px]">
            <div class="absolute inset-0 bg-[#064E3B]/5 group-hover:opacity-0 transition-opacity duration-500 z-10 pointer-events-none"></div>
            <MapEmbed height="100%" address="广东省珠海市金湾区创业北路20号厂房(三期)2层" />
          </div>
          
          <div class="order-1 lg:order-2">
            <div class="inline-block px-4 py-1.5 mb-4 bg-[#059669]/10 text-[#059669] font-semibold tracking-wider text-sm rounded-sm uppercase">联系我们</div>
            <h2 class="text-4xl md:text-5xl font-heading font-bold text-[#064E3B] mb-6">快速响应，<span class="text-[#10B981]">高效交付</span></h2>
            <p class="text-[#064E3B]/70 text-lg mb-10">自有生产基地，成熟物流配送体系，为您的生产线保驾护航。</p>
            
            <div class="space-y-6">
              <!-- Location Info -->
              <div class="flex items-start gap-4">
                <div class="w-12 h-12 shrink-0 bg-white rounded-lg border border-[#10B981]/20 flex items-center justify-center text-[#10B981]">
                  <span class="i-carbon-building text-2xl"></span>
                </div>
                <div>
                  <h4 class="text-xl font-heading font-bold text-[#064E3B] mb-1">工厂地址</h4>
                  <p class="text-[#064E3B]/70">广东省珠海市金湾区创业北路20号厂房(三期)2层</p>
                </div>
              </div>
              
              <!-- Contact Info -->
              <div class="flex items-start gap-4">
                <div class="w-12 h-12 shrink-0 bg-white rounded-lg border border-[#10B981]/20 flex items-center justify-center text-[#10B981]">
                  <span class="i-carbon-phone text-2xl"></span>
                </div>
                <div>
                  <h4 class="text-xl font-heading font-bold text-[#064E3B] mb-1">服务热线</h4>
                  <p class="text-[#064E3B]/70">0756-8677810<span class="text-sm ml-2 bg-[#F97316]/10 text-[#F97316] px-2 py-0.5 rounded">24/7 响应</span></p>
                </div>
              </div>
              
              <!-- Business Hours -->
              <div class="flex items-start gap-4">
                <div class="w-12 h-12 shrink-0 bg-white rounded-lg border border-[#10B981]/20 flex items-center justify-center text-[#10B981]">
                  <span class="i-carbon-time text-2xl"></span>
                </div>
                <div>
                  <h4 class="text-xl font-heading font-bold text-[#064E3B] mb-1">营业时间</h4>
                  <p class="text-[#064E3B]/70">周一至周六 08:00 - 18:00</p>
                </div>
              </div>
            </div>
            
            <div class="mt-10">
              <NuxtLink to="/contact" class="inline-flex items-center gap-2 px-8 py-3 bg-[#064E3B] text-white font-heading font-semibold tracking-wider text-base uppercase hover:bg-[#059669] transition-all duration-300 rounded shadow-md group">
                在线获取报价
                <span class="i-carbon-arrow-right text-lg group-hover:translate-x-1 transition-transform"></span>
              </NuxtLink>
            </div>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<script setup lang="ts">
import { COMPANY_EMAIL, COMPANY_PHONE } from '~/utils/contactInfo'

const config = useRuntimeConfig()
const publicAsset = (path: string) => resolvePublicAssetUrl(path, config.app.cdnURL)

// SEO Structured Data - use useHead for JSON-LD
const organizationSchema = JSON.stringify({
  "@context": "https://schema.org",
  "@type": "Organization",
  "name": "珠海市顺泰包装材料有限公司",
  "alternateName": "顺泰包装",
  "url": "https://suntaizh.cn",
  "logo": publicAsset('/favicon.ico'),
  "description": "专业生产珍珠棉、泡沫棉、透明胶、双面胶、海绵胶、打包带、保护膜、制袋等包装材料，厂家直销",
  "areaServed": {
    "@type": "Place",
    "name": "广东省珠海市"
  },
  "contactPoint": {
    "@type": "ContactPoint",
    "telephone": COMPANY_PHONE,
    "contactType": "customer service",
    "availableLanguage": ["Chinese", "Mandarin"]
  }
})

const localBusinessSchema = JSON.stringify({
  "@context": "https://schema.org",
  "@type": "LocalBusiness",
  "name": "珠海市顺泰包装材料有限公司",
  "image": publicAsset('/images/products/hero-factory.jpg'),
  "url": "https://suntaizh.cn",
  "telephone": COMPANY_PHONE,
  "email": COMPANY_EMAIL,
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
})

useHead({
  title: '珠海包装材料厂家_专业生产珍珠棉_透明胶_打包带_保护膜-顺泰包装',
  meta: [
    { name: 'description', content: '珠海市顺泰包装材料有限公司专业生产珍珠棉、泡沫棉、透明胶、双面胶、海绵胶、打包带、保护膜、制袋等包装材料，15年行业经验，厂家直销，价格优惠，服务珠海、中山、江门等珠三角地区。' },
    { name: 'keywords', content: '珠海包装材料,珍珠棉厂家,泡沫棉,透明胶,双面胶,海绵胶,打包带,保护膜,制袋,珠海包装厂家,中山包装材料,江门包装' },
    { property: 'og:title', content: '珠海市顺泰包装材料有限公司 - 专业包装材料生产厂家' },
    { property: 'og:description', content: '专业生产珍珠棉、泡沫棉、透明胶、双面胶、海绵胶、打包带、保护膜、制袋等包装材料，厂家直销，品质保障' },
    { property: 'og:url', content: 'https://suntaizh.cn/' },
    { property: 'og:type', content: 'website' }
  ],
  script: [
    {
      type: 'application/ld+json',
      children: organizationSchema
    },
    {
      type: 'application/ld+json',
      children: localBusinessSchema
    }
  ]
})
</script>

<style>
@import url('https://fonts.googleapis.com/css2?family=Lexend:wght@300;400;500;600;700&family=Source+Sans+3:wght@300;400;500;600;700&display=swap');

.font-heading {
  font-family: 'Lexend', sans-serif;
}
.font-sans {
  font-family: 'Source Sans 3', sans-serif;
}

/* Creative Tape Animations */
@keyframes tape-seal-right {
  0% { transform: rotate(-45deg) scaleX(0); opacity: 0; }
  100% { transform: rotate(-45deg) scaleX(1); opacity: 1; }
}
@keyframes marquee {
  0% { transform: translateX(0); }
  100% { transform: translateX(-50%); }
}

.animate-tape-seal-right {
  animation: tape-seal-right 1.2s cubic-bezier(0.86, 0, 0.07, 1) forwards;
  transform: rotate(-45deg) scaleX(0);
}
.animate-marquee {
  animation: marquee 15s linear infinite;
  width: max-content;
}

@keyframes fadeUp {
  from {
    opacity: 0;
    transform: translateY(20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

/* Button Tape Peel Effect */
.btn-peel {
  position: relative;
}
.btn-peel::after {
  content: '';
  position: absolute;
  bottom: 0;
  right: 0;
  width: 0;
  height: 0;
  background: linear-gradient(135deg, transparent 50%, rgba(255,255,255,0.6) 50%);
  box-shadow: -2px -2px 4px rgba(0,0,0,0.1);
  transition: all 0.3s ease;
}
.btn-peel:hover::after {
  width: 20px;
  height: 20px;
}
</style>
