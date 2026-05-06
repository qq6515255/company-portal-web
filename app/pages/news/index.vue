<template>
  <div class="min-h-screen bg-[#FAFAFA] font-sans text-[#064E3B]">
    <!-- Hero -->
    <section class="relative bg-[#064E3B] py-20 md:py-32 overflow-hidden">
      <div class="absolute inset-0 opacity-10 bg-[url('https://www.transparenttextures.com/patterns/cubes.png')]"></div>
      <div class="absolute inset-0 bg-gradient-to-b from-[#064E3B] to-transparent"></div>
      <div class="container-base relative z-10 text-center text-white">
        <div class="inline-flex items-center gap-2 px-4 py-2 mb-6 bg-[#059669]/30 backdrop-blur-md border border-[#10B981]/50 text-white font-medium tracking-widest text-sm rounded-sm uppercase">
          <span class="w-2 h-2 rounded-full bg-[#10B981] animate-pulse"></span>
          NEWS & ARTICLES
        </div>
        <h1 class="text-4xl md:text-5xl lg:text-6xl font-heading font-bold mb-6 tracking-tight">新闻资讯</h1>
        <p class="text-lg md:text-xl text-emerald-100 max-w-2xl mx-auto font-light leading-relaxed">
          包装行业动态、产品知识、公司新闻，助您掌握最新行业趋势
        </p>
      </div>
    </section>

    <!-- Category Filter -->
    <section class="py-8 bg-white border-b border-gray-200 sticky top-0 z-40 shadow-sm">
      <div class="container-base">
        <div class="flex flex-wrap justify-center gap-3">
          <button
            v-for="cat in newsCategories"
            :key="cat"
            @click="activeCategory = cat"
            :class="[
              'px-6 py-2.5 rounded-sm font-heading font-medium transition-all duration-300 uppercase tracking-wide text-sm',
              activeCategory === cat
                ? 'bg-[#10B981] text-white shadow-md shadow-[#10B981]/30 -translate-y-0.5'
                : 'bg-[#ECFDF5] text-[#064E3B] hover:bg-[#D1FAE5] hover:text-[#059669]'
            ]"
          >
            {{ cat }}
          </button>
        </div>
      </div>
    </section>

    <!-- News Grid -->
    <section class="py-16 md:py-24 bg-[#FAFAFA]">
      <div class="container-base">
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
          <NuxtLink
            v-for="(item, index) in filteredNews"
            :key="item.slug"
            :to="`/news/${item.slug}`"
            class="group bg-white rounded-lg shadow-sm hover:shadow-xl border border-gray-100 hover:border-[#10B981]/30 transition-all duration-500 overflow-hidden flex flex-col"
            :style="{ animationDelay: `${index * 100}ms` }"
            style="animation: fadeUp 0.6s ease-out forwards;"
          >
            <div class="relative overflow-hidden">
              <div class="bg-[#064E3B] w-full h-56 flex items-center justify-center group-hover:bg-[#059669] transition-colors duration-500">
                <span class="i-carbon-document text-6xl text-[#10B981]/40 group-hover:text-white/30 group-hover:scale-110 transition-all duration-500"></span>
              </div>
              <span class="absolute top-4 left-4 bg-[#F97316]/90 backdrop-blur text-white text-xs px-3 py-1.5 rounded-sm font-heading uppercase tracking-wider">
                {{ item.category }}
              </span>
            </div>
            <div class="p-8 flex-1 flex flex-col">
              <div class="flex items-center gap-3 text-[#064E3B]/50 text-sm mb-3">
                <span class="i-carbon-calendar text-sm"></span>
                <span>{{ item.date }}</span>
              </div>
              <h3 class="text-xl font-heading font-bold text-[#064E3B] mb-3 group-hover:text-[#10B981] transition-colors duration-300 line-clamp-2">
                {{ item.title }}
              </h3>
              <p class="text-[#064E3B]/70 mb-6 line-clamp-2 leading-relaxed flex-1">{{ item.summary }}</p>
              <div class="flex items-center justify-between pt-4 border-t border-gray-100">
                <div class="flex flex-wrap gap-2">
                  <span
                    v-for="tag in item.tags.slice(0, 2)"
                    :key="tag"
                    class="text-xs bg-[#ECFDF5] text-[#059669] px-2 py-1 rounded-sm"
                  >
                    {{ tag }}
                  </span>
                </div>
                <span class="text-[#F97316] font-heading font-semibold text-sm uppercase tracking-wider flex items-center group-hover:translate-x-1 transition-transform duration-300">
                  阅读全文 <span class="i-carbon-arrow-right ml-1 text-lg"></span>
                </span>
              </div>
            </div>
          </NuxtLink>
        </div>
      </div>
    </section>

    <!-- CTA -->
    <section class="py-20 bg-[#F97316] relative overflow-hidden">
      <div class="absolute inset-0 opacity-10 bg-[url('https://www.transparenttextures.com/patterns/carbon-fibre.png')]"></div>
      <div class="container-base text-center relative z-10">
        <h2 class="text-3xl md:text-5xl font-heading font-bold mb-6 text-white tracking-tight">需要包装解决方案？</h2>
        <p class="text-white/90 mb-10 text-lg max-w-2xl mx-auto">我们的专家团队随时为您提供专业的评估与定制化解决方案。</p>
        <NuxtLink to="/contact" class="inline-flex items-center gap-2 bg-white text-[#F97316] px-10 py-4 rounded-sm font-heading font-bold text-lg uppercase tracking-wider hover:bg-gray-50 hover:shadow-lg hover:-translate-y-1 transition-all duration-300"
        >
          <span class="i-carbon-phone text-xl"></span>
          立即联系专家团队
        </NuxtLink>
      </div>
    </section>
  </div>
</template>

<script setup lang="ts">
const activeCategory = ref('全部')
const filteredNews = computed(() => getNewsByCategory(activeCategory.value))

useHead({
  title: '新闻资讯 - 珠海市顺泰包装材料有限公司',
  meta: [
    { name: 'description', content: '了解包装行业最新动态、产品知识、公司新闻。珠海市顺泰包装材料有限公司为您提供专业的包装材料解决方案。' },
    { name: 'keywords', content: '包装行业新闻,包装材料知识,珍珠棉选购,胶带选购,绿色包装,珠海包装厂' }
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