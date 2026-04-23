<template>
  <footer class="bg-gray-900 text-white">
    <div class="container-base py-12">
      <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
        <!-- Company Info Column -->
        <div>
          <h3 class="text-xl font-bold mb-4">某某企业</h3>
          <p class="text-gray-400 mb-4">专业企业门户解决方案，为您提供优质的产品和服务。</p>
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
              <span>邮箱: info@example.com</span>
            </li>
            <li class="flex items-start gap-3">
              <span class="i-carbon-location text-lg mt-1" />
              <span>地址: 某某省某某市某某区某某路123号</span>
            </li>
          </ul>
        </div>
      </div>

      <!-- Copyright -->
      <div class="border-t border-gray-800 mt-8 pt-8 text-center text-gray-400">
        <p>© 2024 某某企业 版权所有</p>
      </div>
    </div>
  </footer>
</template>

<script setup lang="ts">
// App Footer Component
</script>
