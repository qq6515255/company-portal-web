<template>
  <div class="bg-white rounded-lg shadow-md p-4 text-center cursor-pointer hover:shadow-lg transition-shadow">
    <a
      :href="`https://wpa.qq.com/msgrd?v=3&uin=${qqNumber}&site=qq&menu=yes`"
      target="_blank"
      rel="noopener"
      class="block"
    >
      <div class="w-16 h-16 mx-auto mb-2 bg-blue-500 rounded-lg flex items-center justify-center">
        <span class="text-3xl text-white">💬</span>
      </div>
      <h4 class="font-medium mb-1">QQ 咨询</h4>
      <p class="text-sm text-gray-500">在线客服</p>
      <span class="inline-block mt-3 text-blue-500 hover:text-blue-600 font-medium">
        点击咨询
      </span>
    </a>
  </div>
</template>

<script setup lang="ts">
interface Props {
  qqNumber?: string
}

withDefaults(defineProps<Props>(), {
  qqNumber: '123456789'
})
</script>
