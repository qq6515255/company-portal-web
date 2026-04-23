<template>
  <div class="flex flex-col min-h-screen">
    <AppHeader />
    <main class="flex-1">
      <slot />
    </main>
    <AppFooter />
    <FloatingConsult />
  </div>
</template>

<script setup lang="ts">
// Default Layout wrapper with AppHeader and AppFooter
</script>
