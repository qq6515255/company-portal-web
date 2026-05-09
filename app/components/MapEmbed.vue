<template>
  <div class="map-embed-wrapper h-full">
    <div
      ref="mapContainerRef"
      :style="{
        width: width || '100%',
        height: height || '300px'
      }"
      class="map-container"
    />
    <div v-if="loadError" class="map-error text-center py-4 text-gray-500">
      <p>地图加载失败: {{ loadError }}</p>
      <p v-if="address" class="text-sm mt-1">{{ address }}</p>
    </div>
  </div>
</template>

<script setup lang="ts">
let amapLoaderPromise: Promise<any> | null = null

interface Props {
  lng?: number
  lat?: number
  zoom?: number
  width?: string
  height?: string
  address?: string
}

const props = withDefaults(defineProps<Props>(), {
  lng: 113.282937,
  lat: 22.096994,
  zoom: 16,
  width: '100%',
  height: '300px',
  address: '珠海市顺泰包装材料有限公司'
})

const config = useRuntimeConfig()
const mapContainerRef = ref<HTMLElement | null>(null)
const mapLoaded = ref(false)
const loadError = ref('')

let mapInstance: any = null

const loadAMap = async (apiKey: string, securityJsCode: string) => {
  if (securityJsCode) {
    ;(window as any)._AMapSecurityConfig = {
      securityJsCode
    }
  }

  if (!(window as any).AMapLoader) {
    const loaderScript = document.createElement('script')
    loaderScript.src = 'https://webapi.amap.com/loader.js'
    loaderScript.async = true

    await new Promise<void>((resolve, reject) => {
      loaderScript.onload = () => resolve()
      loaderScript.onerror = () => reject(new Error('高德地图加载器加载失败'))
      document.head.appendChild(loaderScript)
    })
  }

  return (window as any).AMapLoader.load({
    key: apiKey,
    version: '2.0'
  })
}

onMounted(async () => {
  // 等待 DOM 渲染完成
  await nextTick()
  
  if (!mapContainerRef.value) {
    loadError.value = '地图容器未找到'
    return
  }

  try {
    const apiKey = (config.public as any).amapApiKey || ''
    const securityJsCode = (config.public as any).amapSecurityJsCode || ''

    if (!apiKey) {
      throw new Error('高德地图 Key 未配置')
    }

    if (!amapLoaderPromise) {
      amapLoaderPromise = loadAMap(apiKey, securityJsCode)
    }

    const AMap = await amapLoaderPromise

    mapInstance = new AMap.Map(mapContainerRef.value, {
      zoom: props.zoom,
      center: [props.lng, props.lat],
      viewMode: '2D'
    })

    const marker = new AMap.Marker({
      position: [props.lng, props.lat]
    })
    mapInstance.add(marker)

    if (props.address) {
      const infoWindow = new AMap.InfoWindow({
        content: `<div style="padding:8px;font-size:14px;">${props.address}</div>`,
        offset: new AMap.Pixel(0, -30)
      })
      infoWindow.open(mapInstance, new AMap.LngLat(props.lng, props.lat))
    }

    mapLoaded.value = true
  } catch (error: any) {
    loadError.value = error?.message || '未知错误'
    amapLoaderPromise = null
  }
})

onUnmounted(() => {
  if (mapInstance) {
    mapInstance.destroy()
    mapInstance = null
  }
})
</script>

<style scoped>
.map-embed-wrapper {
  position: relative;
}

.map-container {
  border-radius: 8px;
  overflow: hidden;
  background: #f0f0f0;
}

.map-error {
  background: #f9fafb;
  border-radius: 8px;
}
</style>
