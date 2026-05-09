// https://nuxt.com/docs/api/configuration/nuxt-config
const normalizePrefix = (value: string) => value.replace(/^\/+|\/+$/g, '')

const appendPrefixIfNeeded = (baseURL: string, prefix: string) => {
  const normalizedBaseURL = baseURL.replace(/\/$/, '')
  const normalizedPrefix = normalizePrefix(prefix)

  if (!normalizedBaseURL || !normalizedPrefix) {
    return normalizedBaseURL
  }

  return normalizedBaseURL.endsWith(`/${normalizedPrefix}`)
    ? normalizedBaseURL
    : `${normalizedBaseURL}/${normalizedPrefix}`
}

const cdnPrefix = process.env.NUXT_APP_CDN_PREFIX || process.env.OSS_PREFIX || ''
const cdnURL = appendPrefixIfNeeded(process.env.NUXT_APP_CDN_URL || '', cdnPrefix)
const publicAsset = (path: string) => (cdnURL ? `${cdnURL}${path}` : path)

export default defineNuxtConfig({
  compatibilityDate: '2025-07-15',
  devtools: { enabled: false },

  // UnoCSS module
  modules: ['@unocss/nuxt'],

  // CSS reset
  css: ['./node_modules/@unocss/reset/tailwind.css'],

  // SSG for SEO - pre-render all pages
  ssr: true,

  // Runtime config for public keys
  runtimeConfig: {
    public: {
      amapApiKey: process.env.NUXT_PUBLIC_AMAP_API_KEY || process.env.AMAP_API_KEY || '',
      amapSecurityJsCode: process.env.NUXT_PUBLIC_AMAP_SECURITY_JS_CODE || process.env.AMAP_SECURITY_JS_CODE || ''
    }
  },

  // App configuration
  app: {
    cdnURL,
    head: {
      htmlAttrs: {
        lang: 'zh-CN'
      },
      title: '珠海市顺泰包装材料有限公司_专业包装材料生产厂家',
      meta: [
        { charset: 'utf-8' },
        { name: 'viewport', content: 'width=device-width, initial-scale=1' },
        // 百度 SEO
        { name: 'description', content: '珠海市顺泰包装材料有限公司专业生产珍珠棉、泡沫棉、透明胶带、双面胶、海绵胶、打包带、保护膜、制袋等包装材料，厂家直销，品质保证，服务珠海、中山、江门等珠三角地区。' },
        { name: 'keywords', content: '珠海包装材料,珍珠棉厂家,泡沫棉,透明胶带,双面胶,海绵胶,打包带,保护膜,制袋,珠海包装,中山包装材料,江门包装,包装材料批发' },
        { name: 'author', content: '珠海市顺泰包装材料有限公司' },
        { name: 'robots', content: 'index, follow, max-snippet:-1, max-image-preview:large' },
        { name: 'googlebot', content: 'index, follow' },
        { name: 'baiduspider', content: 'index, follow' },
        { name: 'sogou spider', content: 'index, follow' },
        { name: 'shenma spider', content: 'index, follow' },
        { name: '360spider', content: 'index, follow' },
        // 百度验证（替换成你的百度站长验证码）
        { name: 'baidu-site-verification', content: 'codeva-OciJm5N9YH' },
        // Open Graph
        { property: 'og:title', content: '珠海市顺泰包装材料有限公司' },
        { property: 'og:description', content: '专业生产珍珠棉、泡沫棉、透明胶带、双面胶、海绵胶、打包带、保护膜、制袋等包装材料' },
        { property: 'og:type', content: 'website' },
        { property: 'og:locale', content: 'zh_CN' },
        { property: 'og:site_name', content: '珠海市顺泰包装材料有限公司' },
        { name: 'twitter:card', content: 'summary_large_image' }
      ],
      script: [
        // 百度统计
        {
          src: 'https://hm.baidu.com/hm.js?YOUR_BAIDU_TONGJI_ID',
          async: true,
          defer: true
        }
      ],
      link: [
        { rel: 'canonical', href: 'https://www.suntaizh.cn' },
        { rel: 'icon', type: 'image/x-icon', href: publicAsset('/favicon.ico') },
        { rel: 'sitemap', type: 'application/xml', title: 'Sitemap', href: '/sitemap.xml' }
      ]
    }
  },

  // UnoCSS configuration
  unocss: {
    // Will auto-import uno.config.ts
  },

  // Nitro configuration for static generation (SSG)
  nitro: {
    preset: 'static',
    prerender: {
      crawlLinks: true,
      routes: [
        '/',
        '/products',
        '/about',
        '/contact',
        '/news',
        // Product detail pages
        '/products/zhenzhumian',
        '/products/paomomian',
        '/products/eva-paomian',
        '/products/touming-jiaodai',
        '/products/shuangmian-jiaodai',
        '/products/meiwenzhi-jiaodai',
        '/products/pp-dabaodai',
        '/products/pet-sugangdai',
        '/products/chanraomo',
        '/products/pe-baohumo',
        '/products/haimian-jiaotiao',
        '/products/qipao-mo',
        '/products/fuhedai',
        '/products/zilidai',
        '/products/fangjingdian-dai',
        // News detail pages
        '/news/epe-foam-guide',
        '/news/packaging-tape-comparison',
        '/news/green-packaging-trend',
        '/news/company-expansion',
        '/news/packaging-cost-control',
        '/news/pe-film-guide'
      ]
    }
  }
})
