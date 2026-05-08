<template>
  <div class="min-h-screen bg-[#FAFAFA] font-sans text-[#064E3B]">
    <!-- Hero Section -->
    <section class="relative bg-[#064E3B] py-20 md:py-32 overflow-hidden">
      <div class="absolute inset-0 opacity-10 bg-[url('https://www.transparenttextures.com/patterns/cubes.png')]"></div>
      <div class="absolute inset-0 bg-gradient-to-b from-[#064E3B] to-transparent"></div>
      <div class="container-base relative z-10 text-center text-white">
        <div class="inline-flex items-center gap-2 px-4 py-2 mb-6 bg-[#059669]/30 backdrop-blur-md border border-[#10B981]/50 text-white font-medium tracking-widest text-sm rounded-sm uppercase">
          <span class="w-2 h-2 rounded-full bg-[#10B981] animate-pulse"></span>
          GET IN TOUCH
        </div>
        <h1 class="text-4xl md:text-5xl lg:text-6xl font-heading font-bold mb-6 tracking-tight">联系我们</h1>
        <p class="text-lg md:text-xl text-emerald-100 max-w-2xl mx-auto font-light leading-relaxed">
          专业包装顾问团队24小时在线，随时为您提供产品报价、打样服务及技术支持。
        </p>
      </div>
    </section>

    <!-- Contact Section -->
    <section class="py-16 md:py-24 bg-[#FAFAFA] -mt-10 relative z-20">
      <div class="container-base">
        <div class="grid grid-cols-1 lg:grid-cols-12 gap-8 lg:gap-12">
          
          <!-- Contact Info Column (Left) -->
          <div class="lg:col-span-5 space-y-8">
            <div class="bg-white rounded-sm shadow-md border border-gray-100 p-8 hover:border-[#10B981]/30 transition-colors duration-300">
              <h2 class="text-2xl font-heading font-bold text-[#064E3B] mb-8 border-l-4 border-[#10B981] pl-4">联系方式</h2>
              <div class="space-y-6">
                <div class="flex items-start gap-5 group">
                  <div class="w-12 h-12 bg-[#ECFDF5] rounded-sm flex items-center justify-center text-[#10B981] group-hover:bg-[#10B981] group-hover:text-white transition-colors duration-300 shrink-0">
                    <span class="i-carbon-location text-2xl"></span>
                  </div>
                  <div>
                    <h3 class="font-heading font-bold text-[#064E3B] mb-1">工厂地址</h3>
                    <p class="text-[#064E3B]/70 leading-relaxed">广东省珠海市金湾区创业北路20号厂房(三期)2层</p>
                    <p class="text-[#10B981] text-sm mt-2 font-medium">导航搜索"顺泰包装"即可到达</p>
                  </div>
                </div>
                
                <div class="w-full h-px bg-gray-100"></div>
                
                <div class="flex items-start gap-5 group">
                  <div class="w-12 h-12 bg-[#ECFDF5] rounded-sm flex items-center justify-center text-[#10B981] group-hover:bg-[#10B981] group-hover:text-white transition-colors duration-300 shrink-0">
                    <span class="i-carbon-phone text-2xl"></span>
                  </div>
                  <div>
                    <h3 class="font-heading font-bold text-[#064E3B] mb-1">联系电话</h3>
                    <p class="text-[#064E3B]/70 font-bold text-lg">400-888-8888</p>
                    <p class="text-[#064E3B]/60 text-sm mt-1">手机: 138-0013-8000（张经理）</p>
                  </div>
                </div>
                
                <div class="w-full h-px bg-gray-100"></div>
                
                <div class="flex items-start gap-5 group">
                  <div class="w-12 h-12 bg-[#ECFDF5] rounded-sm flex items-center justify-center text-[#10B981] group-hover:bg-[#10B981] group-hover:text-white transition-colors duration-300 shrink-0">
                    <span class="i-carbon-email text-2xl"></span>
                  </div>
                  <div>
                    <h3 class="font-heading font-bold text-[#064E3B] mb-1">电子邮箱</h3>
                    <p class="text-[#064E3B]/70">info@suntaizh.cn</p>
                    <p class="text-[#064E3B]/60 text-sm mt-1">Sales@suntaizh.cn（销售部）</p>
                  </div>
                </div>
                
                <div class="w-full h-px bg-gray-100"></div>
                
                <div class="flex items-start gap-5 group">
                  <div class="w-12 h-12 bg-[#ECFDF5] rounded-sm flex items-center justify-center text-[#10B981] group-hover:bg-[#10B981] group-hover:text-white transition-colors duration-300 shrink-0">
                    <span class="i-carbon-time text-2xl"></span>
                  </div>
                  <div>
                    <h3 class="font-heading font-bold text-[#064E3B] mb-1">营业时间</h3>
                    <p class="text-[#064E3B]/70">周一至周六: 08:30 - 18:00</p>
                    <p class="text-[#F97316] text-sm mt-1 font-medium">工厂24小时在线响应</p>
                  </div>
                </div>
              </div>
            </div>

            <!-- Social Media -->
            <div class="bg-white rounded-sm shadow-md border border-gray-100 p-8 hover:border-[#10B981]/30 transition-colors duration-300">
              <h2 class="text-xl font-heading font-bold text-[#064E3B] mb-6 border-l-4 border-[#10B981] pl-4">即时在线客服</h2>
              <div class="flex flex-wrap gap-4">
                <QqChat />
              </div>
              <p class="text-[#064E3B]/50 text-sm mt-6 bg-[#ECFDF5] p-3 rounded-sm border border-[#10B981]/20">
                <span class="i-carbon-idea text-[#10B981] mr-1"></span>点击 QQ 咨询可直接联系在线客服，获取最新产品画册及免费打样服务。
              </p>
            </div>
          </div>

          <!-- Contact Form & Map Column (Right) -->
          <div class="lg:col-span-7 space-y-8">
            <div class="bg-white rounded-sm shadow-md border border-gray-100 p-8 lg:p-10">
              <div class="mb-8">
                <h2 class="text-3xl font-heading font-bold text-[#064E3B] mb-2">获取包装方案</h2>
                <p class="text-[#064E3B]/60">请填写您的需求，我们的包装工程师将在 30 分钟内与您联系。</p>
              </div>
              <!-- Styling the ContactForm inside via deep selectors if necessary or assuming it adopts parent styles -->
              <div class="contact-form-wrapper">
                <ContactForm />
              </div>
            </div>
            
            <!-- Map -->
            <div class="bg-white rounded-sm shadow-md border border-gray-100 overflow-hidden relative group">
              <div class="absolute inset-0 bg-[#064E3B]/5 group-hover:opacity-0 transition-opacity duration-500 z-10 pointer-events-none"></div>
              <MapEmbed height="400px" />
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

<style>
@import url('https://fonts.googleapis.com/css2?family=Lexend:wght@300;400;500;600;700&family=Source+Sans+3:wght@300;400;500;600;700&display=swap');

.font-heading {
  font-family: 'Lexend', sans-serif;
}
.font-sans {
  font-family: 'Source Sans 3', sans-serif;
}

/* Add custom styling for the contact form to match the theme if needed */
.contact-form-wrapper :deep(input),
.contact-form-wrapper :deep(textarea) {
  border-radius: 0.125rem;
  border-color: #e5e7eb;
}
.contact-form-wrapper :deep(input:focus),
.contact-form-wrapper :deep(textarea:focus) {
  border-color: #10B981;
  box-shadow: 0 0 0 2px rgba(16, 185, 129, 0.2);
}
.contact-form-wrapper :deep(button) {
  background-color: #064E3B;
  border-radius: 0.125rem;
  text-transform: uppercase;
  font-family: 'Lexend', sans-serif;
  font-weight: 600;
  letter-spacing: 0.05em;
  transition: all 0.3s ease;
}
.contact-form-wrapper :deep(button:hover) {
  background-color: #10B981;
  transform: translateY(-2px);
  box-shadow: 0 4px 6px -1px rgba(16, 185, 129, 0.3);
}
</style>
