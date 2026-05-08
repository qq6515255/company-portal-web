<template>
  <div class="bg-white rounded-lg shadow-md p-4 text-center cursor-pointer hover:shadow-lg transition-shadow">
    <a
      :href="qqWebChatUrl"
      target="_blank"
      rel="noopener noreferrer"
      class="block"
      @click.prevent="openQqChat"
    >
      <div class="w-16 h-16 mx-auto mb-2 bg-blue-500 rounded-lg flex items-center justify-center">
        <span class="text-3xl text-white">💬</span>
      </div>
      <h4 class="font-medium mb-1">QQ 咨询</h4>
      <p class="text-sm text-gray-500">QQ：{{ qqNumber }}</p>
      <span class="inline-block mt-3 text-blue-500 hover:text-blue-600 font-medium">
        点击咨询
      </span>
    </a>
  </div>
</template>

<script setup lang="ts">
import { QQ_NUMBER, QQ_WEB_CHAT_URL, openQqChat } from '~/utils/qqContact'

const qqNumber = QQ_NUMBER
const qqWebChatUrl = QQ_WEB_CHAT_URL
</script>
