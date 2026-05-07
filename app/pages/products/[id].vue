<template>
  <div v-if="product" class="min-h-screen bg-[#FAFAFA] font-sans text-[#064E3B]">
    <!-- Breadcrumb -->
    <div class="bg-white border-b border-gray-100">
      <div class="container-base py-4">
        <nav class="flex items-center gap-2 text-sm text-[#064E3B]/60">
          <NuxtLink to="/" class="hover:text-[#10B981] transition-colors">首页</NuxtLink>
          <span class="i-carbon-chevron-right text-xs"></span>
          <NuxtLink to="/products" class="hover:text-[#10B981] transition-colors">产品中心</NuxtLink>
          <span class="i-carbon-chevron-right text-xs"></span>
          <span class="text-[#064E3B] font-medium">{{ product.name }}</span>
        </nav>
      </div>
    </div>

    <!-- Product Hero -->
    <section class="bg-white py-16 md:py-24">
      <div class="container-base">
        <div class="grid grid-cols-1 lg:grid-cols-2 gap-12 lg:gap-20 items-center">
          <!-- Product Image -->
          <div class="relative group">
            <div class="absolute -inset-4 bg-[#ECFDF5] rounded-lg transform -rotate-1 group-hover:rotate-0 transition-transform duration-500"></div>
            <div class="relative bg-[#064E3B] rounded-lg overflow-hidden shadow-xl border border-[#10B981]/20 aspect-[4/3] flex items-center justify-center">
              <img
                :src="product.image"
                :alt="product.name"
                class="w-full h-full object-cover opacity-80 group-hover:opacity-100 group-hover:scale-105 transition-all duration-700"
                @error="handleImageError"
              />
              <div v-if="imageError" class="absolute inset-0 flex items-center justify-center">
                <span class="i-carbon-package text-8xl text-[#10B981]/30"></span>
              </div>
              <div class="absolute top-4 left-4">
                <span class="bg-[#10B981] text-white text-xs px-3 py-1.5 rounded-sm font-heading uppercase tracking-wider">
                  {{ product.category }}
                </span>
              </div>
            </div>
          </div>

          <!-- Product Info -->
          <div>
            <div class="inline-flex items-center gap-2 px-3 py-1 mb-4 bg-[#ECFDF5] text-[#059669] font-medium text-sm rounded-sm">
              <span class="w-2 h-2 rounded-full bg-[#10B981]"></span>
              {{ product.category }}
            </div>

            <h1 class="text-4xl md:text-5xl font-heading font-bold text-[#064E3B] mb-6 tracking-tight">
              {{ product.name }}
            </h1>

            <p class="text-[#064E3B]/70 text-lg leading-relaxed mb-8">
              {{ product.detailDesc }}
            </p>

            <div class="flex flex-wrap gap-3 mb-8">
              <span class="px-4 py-2 bg-[#ECFDF5] text-[#064E3B] text-sm font-medium rounded-sm border border-[#10B981]/20">
                {{ product.spec }}
              </span>
            </div>

            <div class="flex flex-col sm:flex-row gap-4">
              <NuxtLink
                to="/contact"
                class="inline-flex items-center justify-center gap-2 px-8 py-4 bg-[#F97316] text-white font-heading font-semibold tracking-wider text-base uppercase rounded-sm hover:bg-[#ea580c] transition-all duration-300 shadow-lg hover:shadow-xl hover:-translate-y-0.5"
              >
                <span class="i-carbon-phone text-lg"></span>
                获取报价
              </NuxtLink>

              <NuxtLink
                to="/products"
                class="inline-flex items-center justify-center gap-2 px-8 py-4 bg-white text-[#064E3B] font-heading font-semibold tracking-wider text-base uppercase rounded-sm border-2 border-[#064E3B] hover:bg-[#064E3B] hover:text-white transition-all duration-300"
              >
                <span class="i-carbon-arrow-left text-lg"></span>
                返回产品列表
              </NuxtLink>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Features & Applications -->
    <section class="py-16 md:py-24 bg-[#FAFAFA]">
      <div class="container-base">
        <div class="grid grid-cols-1 lg:grid-cols-2 gap-12">
          <!-- Features -->
          <div class="bg-white rounded-lg p-8 md:p-10 shadow-sm border border-gray-100">
            <div class="flex items-center gap-3 mb-8">
              <div class="w-12 h-12 bg-[#ECFDF5] rounded-lg flex items-center justify-center">
                <span class="i-carbon-checkmark-filled text-2xl text-[#10B981]"></span>
              </div>
              <h2 class="text-2xl font-heading font-bold text-[#064E3B]">产品特点</h2>
            </div>

            <ul class="space-y-4">
              <li
                v-for="feature in product.features"
                :key="feature"
                class="flex items-start gap-3"
              >
                <span class="i-carbon-checkmark text-lg text-[#10B981] mt-0.5 shrink-0"></span>
                <span class="text-[#064E3B]/80">{{ feature }}</span>
              </li>
            </ul>
          </div>

          <!-- Applications -->
          <div class="bg-white rounded-lg p-8 md:p-10 shadow-sm border border-gray-100">
            <div class="flex items-center gap-3 mb-8">
              <div class="w-12 h-12 bg-[#F97316]/10 rounded-lg flex items-center justify-center">
                <span class="i-carbon-application text-2xl text-[#F97316]"></span>
              </div>
              <h2 class="text-2xl font-heading font-bold text-[#064E3B]">应用场景</h2>
            </div>

            <ul class="space-y-4">
              <li
                v-for="app in product.applications"
                :key="app"
                class="flex items-start gap-3"
              >
                <span class="i-carbon-dot-mark text-lg text-[#F97316] mt-0.5 shrink-0"></span>
                <span class="text-[#064E3B]/80">{{ app }}</span>
              </li>
            </ul>
          </div>
        </div>
      </div>
    </section>

    <!-- Related Products -->
    <section class="py-16 md:py-24 bg-white">
      <div class="container-base">
        <div class="text-center mb-12">
          <h2 class="text-3xl md:text-4xl font-heading font-bold text-[#064E3B] mb-4">
            同类产品推荐
          </h2>
          <p class="text-[#064E3B]/60">更多{{ product.category }}，满足您的不同需求</p>
        </div>

        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8">
          <NuxtLink
            v-for="related in relatedProducts"
            :key="related.id"
            :to="`/products/${related.id}`"
            class="group bg-[#FAFAFA] rounded-lg overflow-hidden hover:shadow-lg hover:-translate-y-1 transition-all duration-300 border border-gray-100"
          >
            <div class="bg-[#ECFDF5] w-full h-48 flex items-center justify-center">
              <span class="i-carbon-package text-5xl text-[#10B981]/40 group-hover:text-[#10B981] group-hover:scale-110 transition-all duration-500"></span>
            </div>
            <div class="p-6">
              <span class="text-xs text-[#059669] font-medium uppercase tracking-wider">{{ related.category }}</span>
              <h3 class="text-xl font-heading font-bold text-[#064E3B] mt-2 mb-3 group-hover:text-[#10B981] transition-colors">
                {{ related.name }}
              </h3>
              <p class="text-[#064E3B]/60 text-sm line-clamp-2">{{ related.desc }}</p>
            </div>
          </NuxtLink>
        </div>
      </div>
    </section>

    <!-- CTA -->
    <section class="py-20 bg-[#F97316] relative overflow-hidden">
      <div class="absolute inset-0 opacity-10 bg-[url('https://www.transparenttextures.com/patterns/carbon-fibre.png')]"></div>
      <div class="container-base text-center relative z-10">
        <h2 class="text-3xl md:text-4xl font-heading font-bold mb-6 text-white tracking-tight">
          需要{{ product.name }}的定制方案？
        </h2>
        <p class="text-white/90 mb-10 text-lg max-w-2xl mx-auto">
          我们提供从选型到生产的一站式服务，根据您的具体需求定制规格、尺寸和数量。
        </p>
        <NuxtLink
          to="/contact"
          class="inline-flex items-center gap-2 bg-white text-[#F97316] px-10 py-4 rounded-sm font-heading font-bold text-lg uppercase tracking-wider hover:bg-gray-50 hover:shadow-lg hover:-translate-y-1 transition-all duration-300"
        >
          <span class="i-carbon-phone text-xl"></span>
          立即咨询
        </NuxtLink>
      </div>
    </section>
  </div>

  <!-- 404 -->
  <div v-else class="min-h-screen bg-[#FAFAFA] flex items-center justify-center">
    <div class="text-center">
      <span class="i-carbon-warning-alt text-6xl text-[#064E3B]/20 mb-6 block"></span>
      <h1 class="text-4xl font-heading font-bold text-[#064E3B] mb-4">产品未找到</h1>
      <p class="text-[#064E3B]/60 mb-8">该产品不存在或已被下架</p>
      <NuxtLink
        to="/products"
        class="inline-flex items-center gap-2 px-8 py-3 bg-[#064E3B] text-white font-heading font-semibold rounded-sm hover:bg-[#059669] transition-colors"
      >
        <span class="i-carbon-arrow-left"></span>
        返回产品列表
      </NuxtLink>
    </div>
  </div>
</template>

<script setup lang="ts">
const route = useRoute()
const productId = route.params.id as string
const products = useProducts()

const product = computed(() => products.value.find(item => item.id === productId))

const relatedProducts = computed(() => {
  if (!product.value) return []
  return products.value
    .filter(p => p.category === product.value!.category && p.id !== product.value!.id)
    .slice(0, 3)
})

const imageError = ref(false)
const handleImageError = () => {
  imageError.value = true
}

// SEO
useHead(() => {
  if (!product.value) return {}
  return {
    title: `${product.value.name} - ${product.value.category} - 珠海市顺泰包装材料有限公司`,
    meta: [
      { name: 'description', content: product.value.desc },
      { property: 'og:title', content: `${product.value.name} - 珠海市顺泰包装材料有限公司` },
      { property: 'og:description', content: product.value.desc },
      { property: 'og:type', content: 'product' }
    ]
  }
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
</style>
