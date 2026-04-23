<template>
  <div class="bg-white rounded-lg shadow-md overflow-hidden hover:shadow-lg transition-shadow">
    <div class="aspect-video bg-gray-200">
      <img v-if="image" :src="image" :alt="title" class="w-full h-full object-cover" />
      <div v-else class="w-full h-full flex-center bg-gray-100">
        <span class="i-carbon-image text-4xl text-gray-400" />
      </div>
    </div>
    <div class="p-4">
      <h3 class="font-bold text-lg mb-2">{{ title }}</h3>
      <p class="text-gray-600 text-sm mb-4 line-clamp-2">{{ description }}</p>
      <NuxtLink :to="`/products/${id}`" class="btn-outline inline-block">
        了解更多
      </NuxtLink>
    </div>
  </div>
</template>

<script setup lang="ts">
interface Props {
  id?: string
  title?: string
  description?: string
  image?: string
}

withDefaults(defineProps<Props>(), {
  id: '',
  title: '产品名称',
  description: '产品描述信息',
  image: ''
})
</script>
