<template>
  <div class="bg-white rounded-lg shadow-md p-4 text-center cursor-pointer hover:shadow-lg transition-shadow">
    <a
      :href="qqWebChatUrl"
      target="_blank"
      rel="noopener noreferrer"
      class="block"
      @click.prevent="openQqChat"
    >
      <div class="relative w-16 h-16 mx-auto mb-3 rounded-2xl bg-gradient-to-br from-blue-500 to-cyan-500 shadow-lg shadow-blue-500/25 flex items-center justify-center">
        <img src="/icon/QQ.svg" alt="QQ咨询" class="h-8 w-8" />
      </div>
      <p class="text-sm text-gray-500">QQ：{{ qqNumber }}</p>
    </a>
  </div>
</template>

<script setup lang="ts">
import { QQ_NUMBER, QQ_WEB_CHAT_URL, openQqChat } from '~/utils/qqContact'

const qqNumber = QQ_NUMBER
const qqWebChatUrl = QQ_WEB_CHAT_URL
</script>
