<template>
  <div class="fixed right-4 bottom-20 z-40 flex flex-col gap-3">
    <!-- QQ咨询 -->
    <a
      :href="qqWebChatUrl"
      target="_blank"
      rel="noopener noreferrer"
      class="flex items-center justify-center w-12 h-12 bg-blue-500 text-white rounded-full shadow-lg hover:bg-blue-600 hover:scale-110 transition-all"
      aria-label="QQ咨询"
      title="QQ咨询"
      @click.prevent="openQqChat"
    >
      <span class="i-carbon-logo-qq text-2xl" />
    </a>

    <!-- 回到顶部 -->
    <button
      v-show="showBackToTop"
      class="flex items-center justify-center w-12 h-12 bg-gray-600 text-white rounded-full shadow-lg hover:bg-gray-700 hover:scale-110 transition-all"
      aria-label="回到顶部"
      title="回到顶部"
      @click="scrollToTop"
    >
      <span class="i-carbon-arrow-up text-xl" />
    </button>
  </div>
</template>

<script setup lang="ts">
import { QQ_WEB_CHAT_URL, openQqChat } from '~/utils/qqContact'

const showBackToTop = ref(false)
const qqWebChatUrl = QQ_WEB_CHAT_URL

const scrollToTop = () => {
  window.scrollTo({ top: 0, behavior: 'smooth' })
}

const handleScroll = () => {
  showBackToTop.value = window.scrollY > 300
}

onMounted(() => {
  window.addEventListener('scroll', handleScroll)
})

onUnmounted(() => {
  window.removeEventListener('scroll', handleScroll)
})
</script>
