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

onMounted(async () => {
  // 等待 DOM 渲染完成
  await nextTick()
  
  if (!mapContainerRef.value) {
    loadError.value = '地图容器未找到'
    console.error('地图容器未找到')
    return
  }

  console.log('开始初始化地图，容器:', mapContainerRef.value)
  console.log('目标经纬度:', props.lng, props.lat)

  try {
    const apiKey = (config.public as any).amapApiKey || ''
    const securityJsCode = (config.public as any).amapSecurityJsCode || ''

    if (!apiKey) {
      throw new Error('AMap API Key 未配置')
    }

    // 设置安全密钥
    if (securityJsCode) {
      ;(window as any)._AMapSecurityConfig = {
        securityJsCode
      }
      console.log('安全密钥已设置')
    }

    // 检查是否已加载
    if (!(window as any).AMapLoader) {
      console.log('加载 AMap Loader...')
      const loaderScript = document.createElement('script')
      loaderScript.src = 'https://webapi.amap.com/loader.js'
      loaderScript.async = true

      await new Promise<void>((resolve, reject) => {
        loaderScript.onload = () => resolve()
        loaderScript.onerror = () => reject(new Error('AMap Loader 加载失败'))
        document.head.appendChild(loaderScript)
      })
      console.log('AMap Loader 加载完成')
    }

    // 初始化 AMap
    console.log('调用 AMapLoader.load，Key:', apiKey)
    const AMap = await (window as any).AMapLoader.load({
      key: apiKey,
      version: '2.0'
    })
    console.log('AMap 对象获取成功:', AMap)

    // 创建地图 - center 直接用数组格式
    mapInstance = new AMap.Map(mapContainerRef.value, {
      zoom: props.zoom,
      center: [props.lng, props.lat],
      viewMode: '2D'
    })
    console.log('地图实例创建成功')

    // 添加标记
    const marker = new AMap.Marker({
      position: [props.lng, props.lat]
    })
    mapInstance.add(marker)

    // 如果有地址，显示信息窗体
    if (props.address) {
      const infoWindow = new AMap.InfoWindow({
        content: `<div style="padding:8px;font-size:14px;">${props.address}</div>`,
        offset: new AMap.Pixel(0, -30)
      })
      // infoWindow.open 的第二个参数需要是 LngLat 对象
      infoWindow.open(mapInstance, new AMap.LngLat(props.lng, props.lat))
    }

    mapLoaded.value = true
    console.log('地图加载完成')
  } catch (error: any) {
    console.error('地图初始化失败:', error)
    loadError.value = error.message || '未知错误'
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
