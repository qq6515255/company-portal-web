<template>
  <footer class="bg-gray-900 text-white">
    <div class="container-base py-12">
      <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
        <!-- Company Info Column -->
        <div>
          <h3 class="text-xl font-bold mb-4">珠海市顺泰包装材料有限公司</h3>
          <p class="text-gray-400 mb-4">专业生产珍珠棉、泡沫棉、透明胶、双面胶、海绵胶、打包带、保护膜、制袋等包装材料，15年行业经验。</p>
          <div class="flex gap-4">
            <a href="#" class="text-gray-400 hover:text-white transition-colors" aria-label="QQ">
              <span class="i-carbon-logo-qq text-2xl" />
            </a>
            <a href="#" class="text-gray-400 hover:text-white transition-colors" aria-label="微信">
              <span class="i-carbon-logo-wechat text-2xl" />
            </a>
            <a href="#" class="text-gray-400 hover:text-white transition-colors" aria-label="邮箱">
              <span class="i-carbon-email text-2xl" />
            </a>
          </div>
        </div>

        <!-- Quick Links Column -->
        <div>
          <h4 class="text-lg font-semibold mb-4">快速链接</h4>
          <ul class="space-y-3">
            <li>
              <NuxtLink to="/" class="text-gray-400 hover:text-white transition-colors">首页</NuxtLink>
            </li>
            <li>
              <NuxtLink to="/products" class="text-gray-400 hover:text-white transition-colors">产品介绍</NuxtLink>
            </li>
            <li>
              <NuxtLink to="/about" class="text-gray-400 hover:text-white transition-colors">关于我们</NuxtLink>
            </li>
            <li>
              <NuxtLink to="/news" class="text-gray-400 hover:text-white transition-colors">新闻资讯</NuxtLink>
            </li>
            <li>
              <NuxtLink to="/contact" class="text-gray-400 hover:text-white transition-colors">联系我们</NuxtLink>
            </li>
          </ul>
        </div>

        <!-- Contact Info Column -->
        <div>
          <h4 class="text-lg font-semibold mb-4">联系方式</h4>
          <ul class="space-y-3 text-gray-400">
            <li class="flex items-center gap-3">
              <span class="i-carbon-phone text-lg" />
              <span>电话: 400-888-8888</span>
            </li>
            <li class="flex items-center gap-3">
              <span class="i-carbon-email text-lg" />
              <span>邮箱: info@suntaizh.cn</span>
            </li>
            <li class="flex items-start gap-3">
              <span class="i-carbon-location text-lg mt-1" />
              <span>地址: 广东省珠海市金湾区创业北路20号厂房(三期)2层</span>
            </li>
          </ul>
        </div>
      </div>

      <!-- Copyright -->
      <div class="border-t border-gray-800 mt-8 pt-8 text-center text-gray-400">
        <p class="text-sm md:text-base">© {{ currentYear }} 珠海市顺泰包装材料有限公司 版权所有</p>
        <p class="mt-3 flex items-center justify-center gap-2 text-xs md:text-sm text-gray-500">
          <span class="h-px w-8 bg-gray-800" />
          <a
            href="https://beian.miit.gov.cn/"
            target="_blank"
            rel="noopener noreferrer"
            class="inline-flex items-center gap-2 rounded-full border border-gray-800 px-4 py-1.5 transition-colors hover:border-gray-700 hover:text-white"
            aria-label="工信部备案信息"
          >
            <span class="i-carbon-document text-sm" />
            <span>粤ICP备2026038180号-1</span>
          </a>
          <span class="h-px w-8 bg-gray-800" />
        </p>
      </div>
    </div>
  </footer>
</template>

<script setup lang="ts">
const currentYear = new Date().getFullYear()
</script>
