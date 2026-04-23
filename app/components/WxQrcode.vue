<template>
  <div 
    class="bg-white rounded-lg shadow-md p-4 text-center cursor-pointer hover:shadow-lg transition-shadow"
    @click="showModal = true"
  >
    <div class="w-16 h-16 mx-auto mb-2 bg-green-500 rounded-lg flex items-center justify-center">
      <span class="text-3xl text-white">💚</span>
    </div>
    <h4 class="font-medium mb-1">微信咨询</h4>
    <p class="text-sm text-gray-500">扫码关注</p>
    <span class="inline-block mt-3 text-green-500 hover:text-green-600 font-medium">
      点击查看
    </span>

    <!-- QR Code Modal -->
    <Teleport to="body">
      <div 
        v-if="showModal" 
        class="fixed inset-0 bg-black/50 flex items-center justify-center z-50"
        @click.self="showModal = false"
      >
        <div class="bg-white rounded-xl p-8 max-w-sm mx-4 text-center">
          <h3 class="text-xl font-bold mb-4">扫描二维码添加企业微信</h3>
          <div class="w-48 h-48 mx-auto bg-gray-100 rounded-lg flex items-center justify-center mb-4">
            <span v-if="!qrcodeUrl" class="text-gray-400">二维码图片</span>
            <img v-else :src="qrcodeUrl" alt="企业微信二维码" class="w-full h-full object-contain" />
          </div>
          <p class="text-gray-500 text-sm mb-4">{{ companyName || '企业微信' }}</p>
          <button 
            @click="showModal = false"
            class="px-6 py-2 bg-gray-100 hover:bg-gray-200 rounded-lg transition"
          >
            关闭
          </button>
        </div>
      </div>
    </Teleport>
  </div>
</template>

<script setup lang="ts">
interface Props {
  qrcodeUrl?: string
  companyName?: string
}

withDefaults(defineProps<Props>(), {
  qrcodeUrl: '',
  companyName: '企业微信'
})

const showModal = ref(false)
</script>
