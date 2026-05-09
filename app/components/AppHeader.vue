<template>
  <header class="fixed top-0 left-0 right-0 z-50 bg-white/80 backdrop-blur-md shadow-sm">
    <nav class="container-base flex-between py-4">
      <!-- Logo -->
      <NuxtLink to="/" class="text-xl font-bold text-gray-900">珠海市顺泰包装材料有限公司</NuxtLink>

      <!-- Desktop Navigation -->
      <div class="hidden lg:flex items-center gap-8">
        <NuxtLink to="/" class="text-gray-600 hover:text-gray-900 transition-colors">首页</NuxtLink>
        <NuxtLink to="/products" class="text-gray-600 hover:text-gray-900 transition-colors">产品介绍</NuxtLink>
        <NuxtLink to="/about" class="text-gray-600 hover:text-gray-900 transition-colors">关于我们</NuxtLink>
        <NuxtLink to="/news" class="text-gray-600 hover:text-gray-900 transition-colors">新闻资讯</NuxtLink>
        <NuxtLink to="/contact" class="text-gray-600 hover:text-gray-900 transition-colors">联系我们</NuxtLink>
      </div>

      <!-- Desktop Contact Buttons -->
      <div class="hidden lg:flex items-center gap-3">
        <a
          :href="qqWebChatUrl"
          target="_blank"
          rel="noopener noreferrer"
          class="flex items-center gap-3 px-3 py-2 bg-blue-500 text-white rounded-xl shadow-md shadow-blue-500/20 hover:bg-blue-600 transition-colors"
          @click.prevent="openQqChat"
        >
          <span class="flex h-9 w-9 items-center justify-center rounded-full bg-white/18">
            <img src="/icon/QQ.svg" alt="QQ" class="h-5 w-5" />
          </span>
          <span class="font-medium tracking-wide">QQ {{ qqNumber }}</span>
        </a>
      </div>

      <!-- Mobile Hamburger Button -->
      <button
        class="lg:hidden p-2 text-gray-600 hover:text-gray-900"
        aria-label="菜单"
        @click="mobileMenuOpen = true"
      >
        <span class="i-carbon-menu text-2xl" />
      </button>
    </nav>

    <!-- Mobile Drawer Overlay -->
    <Teleport to="body">
      <Transition name="fade">
        <div
          v-if="mobileMenuOpen"
          class="fixed inset-0 bg-black/50 z-50 lg:hidden"
          @click="mobileMenuOpen = false"
        />
      </Transition>

      <!-- Mobile Drawer -->
      <Transition name="slide">
        <div
          v-if="mobileMenuOpen"
          class="fixed top-0 right-0 h-full w-72 bg-white shadow-xl z-50 lg:hidden"
        >
          <div class="flex flex-col h-full">
            <!-- Drawer Header -->
            <div class="flex items-center justify-between p-4 border-b">
              <span class="text-lg font-bold">菜单</span>
              <button
                class="p-2 text-gray-600 hover:text-gray-900"
                aria-label="关闭"
                @click="mobileMenuOpen = false"
              >
                <span class="i-carbon-close text-xl" />
              </button>
            </div>

            <!-- Drawer Navigation -->
            <nav class="flex-1 p-4 space-y-2">
              <NuxtLink
                to="/"
                class="block px-4 py-3 text-gray-700 hover:bg-gray-100 rounded-lg transition-colors"
                @click="mobileMenuOpen = false"
              >
                首页
              </NuxtLink>
              <NuxtLink
                to="/products"
                class="block px-4 py-3 text-gray-700 hover:bg-gray-100 rounded-lg transition-colors"
                @click="mobileMenuOpen = false"
              >
                产品介绍
              </NuxtLink>
              <NuxtLink
                to="/about"
                class="block px-4 py-3 text-gray-700 hover:bg-gray-100 rounded-lg transition-colors"
                @click="mobileMenuOpen = false"
              >
                关于我们
              </NuxtLink>
              <NuxtLink
                to="/news"
                class="block px-4 py-3 text-gray-700 hover:bg-gray-100 rounded-lg transition-colors"
                @click="mobileMenuOpen = false"
              >
                新闻资讯
              </NuxtLink>
              <NuxtLink
                to="/contact"
                class="block px-4 py-3 text-gray-700 hover:bg-gray-100 rounded-lg transition-colors"
                @click="mobileMenuOpen = false"
              >
                联系我们
              </NuxtLink>
            </nav>

            <!-- Drawer Footer -->
            <div class="p-4 border-t space-y-3">
              <a
                :href="qqWebChatUrl"
                target="_blank"
                rel="noopener noreferrer"
                class="w-full flex items-center justify-center gap-3 px-4 py-3 bg-blue-500 text-white rounded-xl hover:bg-blue-600 transition-colors"
                @click.prevent="handleQqClick"
              >
                <span class="flex h-9 w-9 items-center justify-center rounded-full bg-white/18">
                  <img src="/icon/QQ.svg" alt="QQ" class="h-5 w-5" />
                </span>
                <span class="font-medium tracking-wide">QQ {{ qqNumber }}</span>
              </a>
            </div>
          </div>
        </div>
      </Transition>
    </Teleport>
  </header>
</template>

<script setup lang="ts">
import { QQ_NUMBER, QQ_WEB_CHAT_URL, openQqChat } from '~/utils/qqContact'

const mobileMenuOpen = ref(false)
const qqNumber = QQ_NUMBER
const qqWebChatUrl = QQ_WEB_CHAT_URL

const handleQqClick = () => {
  mobileMenuOpen.value = false
  openQqChat()
}

// Close mobile menu on route change
const route = useRoute()
watch(() => route.path, () => {
  mobileMenuOpen.value = false
})
</script>

<style scoped>
.fade-enter-active,
.fade-leave-active {
  transition: opacity 300ms ease;
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}

.slide-enter-active,
.slide-leave-active {
  transition: transform 300ms ease;
}

.slide-enter-from,
.slide-leave-to {
  transform: translateX(100%);
}
</style>
