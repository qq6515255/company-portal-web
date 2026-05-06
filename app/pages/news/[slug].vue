<template>
  <div v-if="newsItem" class="min-h-screen bg-[#FAFAFA] font-sans text-[#064E3B]">
    <!-- Breadcrumb -->
    <div class="bg-white border-b border-gray-100">
      <div class="container-base py-4">
        <nav class="flex items-center gap-2 text-sm text-[#064E3B]/60">
          <NuxtLink to="/" class="hover:text-[#10B981] transition-colors">首页</NuxtLink>
          <span class="i-carbon-chevron-right text-xs"></span>
          <NuxtLink to="/news" class="hover:text-[#10B981] transition-colors">新闻资讯</NuxtLink>
          <span class="i-carbon-chevron-right text-xs"></span>
          <span class="text-[#064E3B] font-medium truncate max-w-[200px] md:max-w-[400px]">{{ newsItem.title }}</span>
        </nav>
      </div>
    </div>

    <!-- Article Header -->
    <section class="bg-white py-16 md:py-24">
      <div class="container-base max-w-4xl">
        <div class="flex items-center gap-3 mb-6">
          <span class="px-3 py-1 bg-[#F97316]/10 text-[#F97316] text-sm font-medium rounded-sm">{{ newsItem.category }}</span>
          <span class="text-[#064E3B]/50 text-sm flex items-center gap-1">
            <span class="i-carbon-calendar"></span>
            {{ newsItem.date }}
          </span>
        </div>

        <h1 class="text-3xl md:text-4xl lg:text-5xl font-heading font-bold text-[#064E3B] mb-8 leading-tight">
          {{ newsItem.title }}
        </h1>

        <p class="text-xl text-[#064E3B]/70 leading-relaxed mb-8">
          {{ newsItem.summary }}
        </p>

        <div class="flex flex-wrap gap-2">
          <span
            v-for="tag in newsItem.tags"
            :key="tag"
            class="text-sm bg-[#ECFDF5] text-[#059669] px-3 py-1 rounded-sm"
          >
            {{ tag }}
          </span>
        </div>
      </div>
    </section>

    <!-- Article Content -->
    <section class="py-16 md:py-24 bg-[#FAFAFA]">
      <div class="container-base max-w-4xl">
        <article class="bg-white rounded-lg p-8 md:p-12 shadow-sm border border-gray-100 prose prose-lg max-w-none">
          <div class="article-content text-[#064E3B]/80 leading-relaxed space-y-6">
            <div v-html="renderedContent"></div>
          </div>
        </article>

        <!-- Share & Navigation -->
        <div class="mt-12 flex flex-col sm:flex-row items-center justify-between gap-6">
          <NuxtLink
            to="/news"
            class="inline-flex items-center gap-2 px-6 py-3 bg-white text-[#064E3B] font-heading font-semibold rounded-sm border border-gray-200 hover:bg-[#064E3B] hover:text-white hover:border-[#064E3B] transition-all duration-300"
          >
            <span class="i-carbon-arrow-left"></span>
            返回新闻列表
          </NuxtLink>

          <NuxtLink
            to="/contact"
            class="inline-flex items-center gap-2 px-6 py-3 bg-[#F97316] text-white font-heading font-semibold rounded-sm hover:bg-[#ea580c] transition-all duration-300 shadow-md"
          >
            <span class="i-carbon-phone"></span>
            咨询相关产品
          </NuxtLink>
        </div>
      </div>
    </section>

    <!-- Related Articles -->
    <section v-if="relatedNews.length" class="py-16 md:py-24 bg-white">
      <div class="container-base">
        <h2 class="text-3xl font-heading font-bold text-[#064E3B] mb-12 text-center">相关文章</h2>

        <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
          <NuxtLink
            v-for="item in relatedNews"
            :key="item.slug"
            :to="`/news/${item.slug}`"
            class="group bg-[#FAFAFA] rounded-lg p-6 hover:shadow-lg hover:-translate-y-1 transition-all duration-300 border border-gray-100"
          >
            <span class="text-xs text-[#F97316] font-medium uppercase tracking-wider">{{ item.category }}</span>
            <h3 class="text-lg font-heading font-bold text-[#064E3B] mt-2 mb-3 group-hover:text-[#10B981] transition-colors line-clamp-2">
              {{ item.title }}
            </h3>
            <p class="text-[#064E3B]/60 text-sm line-clamp-2">{{ item.summary }}</p>
            <div class="mt-4 text-sm text-[#064E3B]/40">{{ item.date }}</div>
          </NuxtLink>
        </div>
      </div>
    </section>
  </div>

  <!-- 404 -->
  <div v-else class="min-h-screen bg-[#FAFAFA] flex items-center justify-center">
    <div class="text-center">
      <span class="i-carbon-warning-alt text-6xl text-[#064E3B]/20 mb-6 block"></span>
      <h1 class="text-4xl font-heading font-bold text-[#064E3B] mb-4">文章未找到</h1>
      <p class="text-[#064E3B]/60 mb-8">该文章不存在或已被删除</p>
      <NuxtLink
        to="/news"
        class="inline-flex items-center gap-2 px-8 py-3 bg-[#064E3B] text-white font-heading font-semibold rounded-sm hover:bg-[#059669] transition-colors"
      >
        <span class="i-carbon-arrow-left"></span>
        返回新闻列表
      </NuxtLink>
    </div>
  </div>
</template>

<script setup lang="ts">
const route = useRoute()
const slug = route.params.slug as string

const newsItem = computed(() => getNewsBySlug(slug))

const renderedContent = computed(() => {
  if (!newsItem.value) return ''
  // Simple markdown-like rendering: convert ## headers and | tables
  let content = newsItem.value.content

  // Convert headers
  content = content.replace(/^### (.+)$/gm, '<h3 class="text-2xl font-heading font-bold text-[#064E3B] mt-10 mb-4">$1</h3>')
  content = content.replace(/^## (.+)$/gm, '<h2 class="text-3xl font-heading font-bold text-[#064E3B] mt-12 mb-6">$1</h2>')

  // Convert bold
  content = content.replace(/\*\*(.+?)\*\*/g, '<strong class="text-[#064E3B]">$1</strong>')

  // Convert paragraphs (simple split by double newline)
  const paragraphs = content.split('\n\n').filter(p => p.trim())
  content = paragraphs.map(p => {
    if (p.startsWith('<h')) return p
    if (p.startsWith('|')) return renderTable(p)
    if (p.startsWith('- ')) return renderList(p)
    if (p.startsWith('1. ')) return renderOrderedList(p)
    return `<p class="text-[#064E3B]/80 leading-relaxed">${p}</p>`
  }).join('\n')

  return content
})

function renderTable(tableText: string): string {
  const lines = tableText.split('\n').filter(l => l.trim())
  if (lines.length < 3) return `<p>${tableText}</p>`

  const headers = lines[0].split('|').map(h => h.trim()).filter(Boolean)
  const rows = lines.slice(2).map(line =>
    line.split('|').map(c => c.trim()).filter(Boolean)
  )

  let html = '<div class="overflow-x-auto my-8"><table class="w-full border-collapse"><thead><tr class="bg-[#064E3B] text-white">'
  headers.forEach(h => {
    html += `<th class="px-4 py-3 text-left font-heading font-semibold text-sm">${h}</th>`
  })
  html += '</tr></thead><tbody>'

  rows.forEach((row, i) => {
    const bgClass = i % 2 === 0 ? 'bg-white' : 'bg-[#FAFAFA]'
    html += `<tr class="${bgClass} border-b border-gray-100">`
    row.forEach(cell => {
      html += `<td class="px-4 py-3 text-sm text-[#064E3B]/80">${cell}</td>`
    })
    html += '</tr>'
  })

  html += '</tbody></table></div>'
  return html
}

function renderList(listText: string): string {
  const items = listText.split('\n').filter(l => l.trim().startsWith('- ')).map(l => l.replace('- ', '').trim())
  let html = '<ul class="space-y-2 my-6 ml-4">'
  items.forEach(item => {
    html += `<li class="flex items-start gap-2"><span class="i-carbon-checkmark text-[#10B981] mt-1 shrink-0"></span><span>${item}</span></li>`
  })
  html += '</ul>'
  return html
}

function renderOrderedList(listText: string): string {
  const items = listText.split('\n').filter(l => /^\d+\.\s/.test(l.trim()))
  let html = '<ol class="space-y-2 my-6 ml-4 list-decimal">'
  items.forEach(item => {
    const text = item.replace(/^\d+\.\s/, '').trim()
    html += `<li class="text-[#064E3B]/80 pl-2">${text}</li>`
  })
  html += '</ol>'
  return html
}

const relatedNews = computed(() => {
  if (!newsItem.value) return []
  return newsItems
    .filter(n => n.slug !== newsItem.value!.slug && (n.category === newsItem.value!.category || n.tags.some(t => newsItem.value!.tags.includes(t))))
    .slice(0, 3)
})

useHead(() => {
  if (!newsItem.value) return {}
  return {
    title: `${newsItem.value.title} - 珠海市顺泰包装材料有限公司`,
    meta: [
      { name: 'description', content: newsItem.value.summary },
      { property: 'og:title', content: newsItem.value.title },
      { property: 'og:description', content: newsItem.value.summary },
      { property: 'og:type', content: 'article' },
      { property: 'article:published_time', content: newsItem.value.date }
    ]
  }
})
</script>

<style>
@import url('https://fonts.googleapis.com/css2?family=Lexend:wght@300;400;500;600;700&family=Source+Sans+3:wght@300;400;500;600;700&display=swap');

.font-heading {
  font-family: 'Lexend', sans-serif;
}
.font-sans {
  font-family: 'Source Sans 3', sans-serif;
}
</style>