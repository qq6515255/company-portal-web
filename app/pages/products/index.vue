<template>
  <div class="min-h-screen">
    <!-- Hero Section -->
    <section class="bg-gradient-to-br from-primary to-secondary py-16 md:py-24">
      <div class="container-base text-center text-white">
        <h1 class="text-3xl md:text-4xl lg:text-5xl font-bold mb-4">包装材料产品中心</h1>
        <p class="text-lg md:text-xl text-white/80 max-w-2xl mx-auto">
          专业生产珍珠棉、泡沫棉、透明胶、双面胶、海绵胶、打包带、保护膜、制袋等包装材料
        </p>
      </div>
    </section>

    <!-- Category Filter -->
    <section class="py-8 bg-white border-b">
      <div class="container-base">
        <div class="flex flex-wrap justify-center gap-3">
          <button 
            v-for="cat in categories" 
            :key="cat"
            @click="activeCategory = cat"
            :class="[
              'px-6 py-2 rounded-full font-medium transition',
              activeCategory === cat 
                ? 'bg-primary text-white' 
                : 'bg-gray-100 text-gray-600 hover:bg-gray-200'
            ]"
          >
            {{ cat }}
          </button>
        </div>
      </div>
    </section>

    <!-- Products Grid -->
    <section class="py-16 md:py-24 bg-gray-50">
      <div class="container-base">
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8">
          <NuxtLink 
            v-for="product in filteredProducts" 
            :key="product.name"
            to="/products"
            class="group bg-white rounded-xl shadow-sm hover:shadow-xl transition-all duration-300 overflow-hidden"
          >
            <div class="relative">
              <div class="bg-gray-200 border-2 border-dashed w-full h-56 flex-center">
                <span class="text-gray-400 text-lg">{{ product.name }}图片</span>
              </div>
              <span class="absolute top-4 left-4 bg-primary/90 text-white text-xs px-3 py-1 rounded-full">
                {{ product.category }}
              </span>
            </div>
            <div class="p-6">
              <h3 class="text-xl font-bold text-gray-900 mb-2 group-hover:text-primary transition">
                {{ product.name }}
              </h3>
              <p class="text-gray-600 mb-4 line-clamp-2">{{ product.desc }}</p>
              <div class="flex items-center justify-between">
                <span class="text-gray-500 text-sm">{{ product.spec }}</span>
                <span class="text-primary font-medium group-hover:underline">查看详情 →</span>
              </div>
            </div>
          </NuxtLink>
        </div>
      </div>
    </section>

    <!-- CTA Section -->
    <section class="py-16 bg-primary text-white">
      <div class="container-base text-center">
        <h2 class="text-2xl md:text-3xl font-bold mb-4">需要定制包装材料？</h2>
        <p class="text-white/80 mb-6">我们提供各种规格的定制服务，满足您的特殊需求</p>
        <NuxtLink to="/contact" class="inline-block bg-white text-primary px-8 py-3 rounded-lg font-medium hover:bg-gray-100 transition">
          联系我们
        </NuxtLink>
      </div>
    </section>
  </div>
</template>

<script setup lang="ts">
const categories = ['全部', '缓冲材料', '粘接材料', '捆扎材料', '防护材料', '定制制袋']

const activeCategory = ref('全部')

const products = [
  // 缓冲材料
  { name: '珍珠棉', category: '缓冲材料', desc: '高性能缓冲防震材料，柔韧性好，适合电子、家具、玻璃等产品的包装防护', spec: '厚度: 0.5-50mm' },
  { name: '泡沫棉', category: '缓冲材料', desc: '轻质缓冲材料，隔音隔热防震，适用于多种产品的包装填充', spec: '密度: 10-50kg/m³' },
  { name: 'EVA泡棉', category: '缓冲材料', desc: '高弹性EVA材料，防水防震，广泛用于鞋材、箱包、电子产品', spec: '硬度: 20-60度' },
  
  // 粘接材料
  { name: '透明胶带', category: '粘接材料', desc: '高透明度胶带，粘性强不残胶，适用于包装封箱、办公等', spec: '宽度: 12-72mm' },
  { name: '双面胶带', category: '粘接材料', desc: '强粘性双面胶，固定、拼接、修补多功能应用', spec: '粘性: 高/中/低' },
  { name: '美纹纸胶带', category: '粘接材料', desc: '易撕不留痕，适用于喷漆遮蔽、墙面保护、办公等', spec: '耐温: 80-120℃' },
  
  // 捆扎材料
  { name: 'PP打包带', category: '捆扎材料', desc: '韧性强、抗拉伸，适用于纸箱、货物捆扎打包', spec: '宽度: 9-19mm' },
  { name: 'PET塑钢带', category: '捆扎材料', desc: '高强度打包带，替代钢带，环保耐用，适用于重货打包', spec: '拉伸强度: ≥250MPa' },
  { name: '缠绕膜', category: '捆扎材料', desc: '拉伸缠绕膜，包装防潮防尘，适用于托盘包装', spec: '厚度: 15-50μm' },
  
  // 防护材料
  { name: 'PE保护膜', category: '防护材料', desc: '表面防护专用膜，防止刮花、灰尘，适用于板材、型材', spec: '粘性: 低/中/高' },
  { name: '海绵胶条', category: '防护材料', desc: '高密度海绵，密封减震，适用于门窗、电子电器', spec: '规格: 可定制' },
  { name: '气泡膜', category: '防护材料', desc: '缓冲气泡膜，防震防压，保护易碎物品', spec: '卷装/片装' },
  
  // 定制制袋
  { name: '复合袋', category: '定制制袋', desc: '多层复合材料袋，防潮阻氧，适用于食品、药品包装', spec: '尺寸: 按需定制' },
  { name: '自立袋', category: '定制制袋', desc: '底部可站立，自封口袋，便于陈列和使用', spec: '材质: PE/复合' },
  { name: '防静电袋', category: '定制制袋', desc: '防静电PE袋，保护电子元件免受静电损害', spec: '规格: 可定制' },
]

const filteredProducts = computed(() => {
  if (activeCategory.value === '全部') return products
  return products.filter(p => p.category === activeCategory.value)
})

useHead({
  title: '包装材料产品中心 - 珠海市顺泰包装材料有限公司',
  meta: [
    { name: 'description', content: '珠海顺泰包装专业生产珍珠棉、泡沫棉、透明胶、双面胶、打包带、保护膜等包装材料，品种齐全，支持定制，服务珠海、中山、江门等珠三角地区。' },
    { name: 'keywords', content: '珠海包装材料,珍珠棉厂家,泡沫棉,透明胶带,双面胶,打包带,保护膜,制袋定制,包装材料批发' },
    { property: 'og:title', content: '包装材料产品中心 - 珠海市顺泰包装材料有限公司' },
    { property: 'og:description', content: '专业生产各类包装材料：珍珠棉、泡沫棉、透明胶、双面胶、打包带、保护膜、制袋等，品种齐全，支持定制' },
    { property: 'og:url', content: 'https://suntaizh.cn/products' }
  ]
})
</script>
