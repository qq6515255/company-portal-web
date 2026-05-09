<template>
  <div class="min-h-screen bg-[#FAFAFA] font-sans text-[#064E3B]">
    <!-- Hero Section -->
    <section class="relative bg-[#064E3B] py-20 md:py-32 overflow-hidden">
      <div class="absolute inset-0 opacity-10 bg-[url('https://www.transparenttextures.com/patterns/cubes.png')]"></div>
      <div class="absolute inset-0 bg-gradient-to-b from-[#064E3B] to-transparent"></div>
      <div class="container-base relative z-10 text-center text-white">
        <div class="inline-flex items-center gap-2 px-4 py-2 mb-6 bg-[#059669]/30 backdrop-blur-md border border-[#10B981]/50 text-white font-medium tracking-widest text-sm rounded-sm uppercase">
          <span class="w-2 h-2 rounded-full bg-[#F97316] animate-pulse"></span>
          ABOUT SUNTAI
        </div>
        <h1 class="text-4xl md:text-5xl lg:text-6xl font-heading font-bold mb-6 tracking-tight">关于顺泰包装</h1>
        <p class="text-lg md:text-xl text-emerald-100 max-w-2xl mx-auto font-light leading-relaxed">
          30年专业包装材料生产厂家，为珠三角企业提供工业级优质包装解决方案。
        </p>
      </div>
    </section>

    <!-- Company Story Section -->
    <section class="py-20 md:py-32 bg-white">
      <div class="container-base">
        <div class="grid grid-cols-1 lg:grid-cols-2 gap-12 lg:gap-20 items-center">
          <!-- Image Placeholder -->
          <div class="relative group">
            <div class="absolute -inset-4 bg-[#ECFDF5] rounded-lg transform rotate-2 group-hover:rotate-1 transition-transform duration-500"></div>
            <div class="bg-[#064E3B] relative rounded-lg w-full h-[400px] flex items-center justify-center overflow-hidden shadow-xl border border-[#10B981]/20">
              <span class="i-carbon-building-large text-8xl text-[#10B981]/40 group-hover:scale-110 transition-transform duration-700"></span>
              <div class="absolute inset-0 bg-gradient-to-tr from-[#064E3B] to-transparent opacity-80"></div>
              <span class="absolute bottom-6 right-6 text-white/50 font-heading font-bold tracking-widest">SUNTAI FACTORY</span>
            </div>
          </div>
          <!-- Text Content -->
          <div>
            <h2 class="text-3xl md:text-4xl font-heading font-bold text-[#064E3B] mb-8">企业<span class="text-[#10B981]">简介</span></h2>
            <p class="text-[#064E3B]/80 leading-relaxed text-lg mb-6">
              <strong>珠海市顺泰包装材料有限公司</strong>成立于1996年，是一家专业从事包装材料生产、销售的企业。公司位于广东省珠海市金湾区，拥有标准化的生产车间和完善的检测设备。
            </p>
            <p class="text-[#064E3B]/80 leading-relaxed text-lg mb-6">
              我们主要产品包括：<strong>珍珠棉、泡沫棉</strong>（缓冲防震材料）、<strong>透明胶、双面胶、海绵胶</strong>（粘接密封材料）、<strong>打包带、保护膜</strong>（捆扎防护材料）以及<strong>各种规格制袋</strong>等。广泛应用于电子、家具、建材、食品、医药等行业的包装需求。
            </p>
            <p class="text-[#064E3B]/80 leading-relaxed text-lg">
              秉承“质量第一、客户至上”的经营理念，我们为<strong>珠海、中山、江门</strong>等珠三角地区企业提供极具性价比的包装解决方案。
            </p>
            <div class="flex flex-wrap gap-4 mt-10">
              <div class="px-6 py-5 bg-[#ECFDF5] rounded-sm flex-1 min-w-[120px] border-l-4 border-[#10B981]">
                <div class="text-3xl font-heading font-bold text-[#064E3B]">500<span class="text-[#10B981]">+</span></div>
                <div class="text-[#064E3B]/60 text-sm mt-1 uppercase tracking-wider">服务企业</div>
              </div>
              <div class="px-6 py-5 bg-[#ECFDF5] rounded-sm flex-1 min-w-[120px] border-l-4 border-[#F97316]">
                <div class="text-3xl font-heading font-bold text-[#064E3B]">30<span class="text-[#F97316]">Y</span></div>
                <div class="text-[#064E3B]/60 text-sm mt-1 uppercase tracking-wider">行业经验</div>
              </div>
              <div class="px-6 py-5 bg-[#ECFDF5] rounded-sm flex-1 min-w-[120px] border-l-4 border-[#059669]">
                <div class="text-3xl font-heading font-bold text-[#064E3B]">50<span class="text-[#059669]">+</span></div>
                <div class="text-[#064E3B]/60 text-sm mt-1 uppercase tracking-wider">产品矩阵</div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Company Timeline -->
    <section class="py-20 md:py-32 bg-[#FAFAFA] border-y border-gray-200">
      <div class="container-base">
        <div class="text-center mb-16">
          <h2 class="text-3xl md:text-4xl font-heading font-bold text-[#064E3B] mb-4">发展<span class="text-[#10B981]">历程</span></h2>
          <p class="text-[#064E3B]/60 uppercase tracking-widest text-sm">Milestones & History</p>
        </div>
        
        <!-- Desktop Timeline -->
        <div class="hidden md:block relative max-w-4xl mx-auto">
          <div class="absolute left-1/2 top-0 bottom-0 w-0.5 bg-[#10B981]/30 transform -translate-x-1/2"></div>
          
          <div class="space-y-16">
            <div class="relative flex items-center group" v-for="(event, index) in timeline" :key="event.year">
              <div class="w-1/2 pr-12 text-right" :class="index % 2 === 0 ? '' : 'order-3 text-left pr-0 pl-12'">
                <div class="bg-white p-8 rounded-sm shadow-sm border border-gray-100 group-hover:border-[#10B981]/50 group-hover:shadow-md transition-all duration-300">
                  <span class="text-[#10B981] font-heading font-bold text-3xl">{{ event.year }}</span>
                  <h3 class="text-xl font-heading font-bold text-[#064E3B] mt-2">{{ event.title }}</h3>
                  <p class="text-[#064E3B]/70 mt-3 leading-relaxed">{{ event.desc }}</p>
                </div>
              </div>
              <div class="absolute left-1/2 transform -translate-x-1/2 w-5 h-5 bg-[#F97316] rounded-full border-4 border-white shadow-md z-10 group-hover:scale-125 transition-transform duration-300" :class="index % 2 === 0 ? '' : 'order-2'"></div>
              <div class="w-1/2 pl-12" :class="index % 2 === 0 ? '' : 'order-1 pr-12 pl-0'"></div>
            </div>
          </div>
        </div>
        
        <!-- Mobile Timeline -->
        <div class="md:hidden space-y-8">
          <div v-for="event in timeline" :key="event.year" class="flex gap-6">
            <div class="flex-shrink-0 flex flex-col items-center">
              <div class="w-12 h-12 bg-[#ECFDF5] rounded-full flex items-center justify-center text-[#10B981] font-heading font-bold border border-[#10B981]/20">{{ event.year.toString().slice(-2) }}</div>
              <div class="w-0.5 h-full bg-[#10B981]/20 mt-4"></div>
            </div>
            <div class="flex-1 bg-white p-6 rounded-sm shadow-sm border border-gray-100 pb-8">
              <span class="text-[#10B981] font-heading font-bold text-xl">{{ event.year }}</span>
              <h3 class="font-heading font-bold text-[#064E3B] text-lg mt-1">{{ event.title }}</h3>
              <p class="text-[#064E3B]/70 mt-2">{{ event.desc }}</p>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Qualifications Section -->
    <!-- <section class="py-20 md:py-32 bg-white">
      <div class="container-base">
        <div class="text-center mb-16">
          <h2 class="text-3xl md:text-4xl font-heading font-bold text-[#064E3B] mb-4">资质<span class="text-[#10B981]">认证</span></h2>
          <p class="text-[#064E3B]/60 uppercase tracking-widest text-sm">Certifications & Awards</p>
        </div>
        
        <div class="grid grid-cols-2 md:grid-cols-4 gap-6 lg:gap-10">
          <div v-for="cert in certifications" :key="cert.name" class="bg-[#ECFDF5] rounded-sm p-8 text-center border border-[#10B981]/10 hover:border-[#10B981]/40 hover:shadow-lg transition-all duration-300 group">
            <div class="w-20 h-20 mx-auto mb-6 flex items-center justify-center bg-white rounded-full shadow-sm group-hover:scale-110 transition-transform duration-300">
              <span class="i-carbon-certificate text-4xl text-[#10B981]"></span>
            </div>
            <h3 class="font-heading font-bold text-[#064E3B] text-lg">{{ cert.name }}</h3>
            <p class="text-[#064E3B]/60 text-sm mt-2">{{ cert.desc }}</p>
          </div>
        </div>
      </div>
    </section> -->

    <!-- Team Section -->
    <!-- <section class="py-20 md:py-32 bg-[#064E3B]">
      <div class="container-base">
        <div class="text-center mb-16">
          <h2 class="text-3xl md:text-4xl font-heading font-bold text-white mb-4">核心<span class="text-[#10B981]">团队</span></h2>
          <p class="text-emerald-100/60 uppercase tracking-widest text-sm">Meet The Experts</p>
        </div>
        
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-8">
          <div v-for="(member, index) in team" :key="member.name" class="bg-[#059669]/20 backdrop-blur border border-white/10 rounded-sm overflow-hidden hover:border-[#10B981]/50 hover:-translate-y-2 transition-all duration-300">
            <div class="h-60 bg-[#059669]/40 flex items-center justify-center relative overflow-hidden">
              <span class="i-carbon-user-avatar-filled-alt text-7xl text-white/20"></span>
              <div class="absolute bottom-0 left-0 w-full h-1/2 bg-gradient-to-t from-[#064E3B] to-transparent"></div>
            </div>
            <div class="p-6 text-center relative z-10 -mt-8">
              <h3 class="font-heading font-bold text-white text-xl">{{ member.name }}</h3>
              <p class="inline-block bg-[#10B981]/20 text-[#10B981] text-xs font-bold px-3 py-1 rounded-sm uppercase tracking-wider mt-2 mb-4">{{ member.title }}</p>
              <p class="text-emerald-100/70 text-sm">{{ member.desc }}</p>
            </div>
          </div>
        </div>
      </div>
    </section> -->

    <!-- CTA Section -->
    <section class="py-20 bg-[#F97316] relative overflow-hidden">
      <div class="absolute inset-0 opacity-10 bg-[url('https://www.transparenttextures.com/patterns/carbon-fibre.png')]"></div>
      <div class="container-base text-center relative z-10">
        <h2 class="text-3xl md:text-4xl font-heading font-bold mb-6 text-white tracking-tight">准备好提升您的包装品质了吗？</h2>
        <p class="text-white/90 mb-10 text-lg max-w-2xl mx-auto">我们的团队随时为您提供专业的评估与定制化解决方案。</p>
        <NuxtLink to="/contact" class="inline-flex items-center gap-2 bg-white text-[#F97316] px-10 py-4 rounded-sm font-heading font-bold text-lg uppercase tracking-wider hover:bg-gray-50 hover:shadow-lg hover:-translate-y-1 transition-all duration-300">
          联系我们
          <span class="i-carbon-arrow-right text-xl"></span>
        </NuxtLink>
      </div>
    </section>
  </div>
</template>

<script setup lang="ts">
const timeline = [
  { year: 1996, title: '企业成立', desc: '珠海市顺泰包装材料有限公司正式成立' },
  { year: 2015, title: '规模扩张', desc: '更换产房，扩大产能' },
  { year: 2023, title: '产品升级', desc: '新增珍珠棉生产线，产品线更加丰富' },
  { year: 2025, title: '服务深化', desc: '为珠三角500+企业提供包装解决方案' },
]

const certifications = [
  { name: 'ISO9001', desc: '质量管理体系认证' },
  { name: 'ISO14001', desc: '环境管理体系认证' },
  { name: '安全生产', desc: '安全生产标准化企业' },
  { name: '诚信企业', desc: '守合同重信用企业' },
]

const team = [
  { name: '张经理', title: '总经理', desc: '20年包装行业经验' },
  { name: '李工', title: '技术总监', desc: '资深包装工程师' },
  { name: '王主管', title: '生产主管', desc: '专注品质管理30年' },
  { name: '陈小姐', title: '销售经理', desc: '专业服务珠三角客户' },
]

useHead({
  title: '关于我们 - 珠海市顺泰包装材料有限公司',
  meta: [
    { name: 'description', content: '了解珠海市顺泰包装材料有限公司的发展历程、资质认证和核心团队。30年专业生产珍珠棉、泡沫棉、透明胶、双面胶、打包带等包装材料厂家。' },
    { name: 'keywords', content: '珠海包装厂家,顺泰包装,包装材料公司,珠海包装材料,关于我们' },
    { property: 'og:title', content: '关于我们 - 珠海市顺泰包装材料有限公司' },
    { property: 'og:description', content: '30年专业包装材料生产厂家，为珠三角企业提供优质包装解决方案' },
    { property: 'og:url', content: 'https://suntaizh.cn/about' }
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
</style>
