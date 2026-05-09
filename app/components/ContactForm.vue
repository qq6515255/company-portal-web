<template>
  <div class="contact-form">
    <form @submit.prevent="handleSubmit" class="space-y-4">
      <!-- 姓名 -->
      <div>
        <label for="name" class="block text-sm font-medium mb-1">姓名 <span class="text-red-500">*</span></label>
        <input
          id="name"
          v-model="form.name"
          type="text"
          :class="[
            'w-full border rounded py-3 px-4 outline-none transition-colors',
            errors.name ? 'border-red-500' : 'border-gray-300',
            'focus:border-primary'
          ]"
          placeholder="请输入您的姓名"
        />
        <p v-if="errors.name" class="text-red-500 text-sm mt-1">{{ errors.name }}</p>
      </div>

      <!-- 公司名称 -->
      <div>
        <label for="company" class="block text-sm font-medium mb-1">公司名称 <span class="text-red-500">*</span></label>
        <input
          id="company"
          v-model="form.company"
          type="text"
          :class="[
            'w-full border rounded py-3 px-4 outline-none transition-colors',
            errors.company ? 'border-red-500' : 'border-gray-300',
            'focus:border-primary'
          ]"
          placeholder="请输入您的公司名称"
        />
        <p v-if="errors.company" class="text-red-500 text-sm mt-1">{{ errors.company }}</p>
      </div>

      <!-- 电话 -->
      <div>
        <label for="phone" class="block text-sm font-medium mb-1">电话 <span class="text-red-500">*</span></label>
        <input
          id="phone"
          v-model="form.phone"
          type="tel"
          :class="[
            'w-full border rounded py-3 px-4 outline-none transition-colors',
            errors.phone ? 'border-red-500' : 'border-gray-300',
            'focus:border-primary'
          ]"
          placeholder="请输入您的联系电话"
        />
        <p v-if="errors.phone" class="text-red-500 text-sm mt-1">{{ errors.phone }}</p>
      </div>

      <!-- 邮箱 -->
      <div>
        <label for="email" class="block text-sm font-medium mb-1">邮箱 <span class="text-red-500">*</span></label>
        <input
          id="email"
          v-model="form.email"
          type="email"
          :class="[
            'w-full border rounded py-3 px-4 outline-none transition-colors',
            errors.email ? 'border-red-500' : 'border-gray-300',
            'focus:border-primary'
          ]"
          placeholder="请输入您的邮箱"
        />
        <p v-if="errors.email" class="text-red-500 text-sm mt-1">{{ errors.email }}</p>
      </div>

      <!-- 咨询内容 -->
      <div>
        <label for="message" class="block text-sm font-medium mb-1">咨询内容 <span class="text-red-500">*</span></label>
        <textarea
          id="message"
          v-model="form.message"
          rows="4"
          :class="[
            'w-full border rounded py-3 px-4 outline-none transition-colors resize-none',
            errors.message ? 'border-red-500' : 'border-gray-300',
            'focus:border-primary'
          ]"
          placeholder="请输入您想咨询的内容"
        ></textarea>
        <p v-if="errors.message" class="text-red-500 text-sm mt-1">{{ errors.message }}</p>
      </div>

      <!-- 提交按钮 -->
      <div>
        <button
          type="submit"
          :disabled="loading"
          class="w-full bg-primary text-white py-3 px-4 rounded font-medium transition-opacity hover:opacity-90 disabled:opacity-50 disabled:cursor-not-allowed"
        >
          {{ loading ? '提交中...' : '提交咨询' }}
        </button>
      </div>

      <!-- 成功提示 -->
      <transition
        enter-active-class="transition duration-300 ease-out"
        enter-from-class="transform -translate-y-2 opacity-0"
        enter-to-class="transform translate-y-0 opacity-100"
        leave-active-class="transition duration-200 ease-in"
        leave-from-class="transform translate-y-0 opacity-100"
        leave-to-class="transform -translate-y-2 opacity-0"
      >
        <div v-if="showSuccess" class="bg-green-50 border border-green-200 text-green-700 p-4 rounded">
          <p class="font-medium">提交成功！</p>
          <p class="text-sm">感谢您的咨询，我们将在24小时内与您联系。</p>
        </div>
      </transition>

      <transition
        enter-active-class="transition duration-300 ease-out"
        enter-from-class="transform -translate-y-2 opacity-0"
        enter-to-class="transform translate-y-0 opacity-100"
        leave-active-class="transition duration-200 ease-in"
        leave-from-class="transform translate-y-0 opacity-100"
        leave-to-class="transform -translate-y-2 opacity-0"
      >
        <div v-if="submitError" class="bg-red-50 border border-red-200 text-red-700 p-4 rounded">
          <p class="font-medium">提交失败</p>
          <p class="text-sm">{{ submitError }}</p>
        </div>
      </transition>
    </form>
  </div>
</template>

<script setup lang="ts">
import { onMounted, reactive, ref } from 'vue'

interface FormData {
  name: string
  company: string
  phone: string
  email: string
  message: string
}

interface FormErrors {
  name?: string
  company?: string
  phone?: string
  email?: string
  message?: string
}

interface ContactLeadLocation {
  lat?: number
  lng?: number
  accuracy?: number
  source?: string
  collectedAt?: string
  address?: string
}

interface ContactLeadResponse {
  success?: boolean
  leadId?: string
  message?: string
  fieldErrors?: FormErrors
}

const form = reactive<FormData>({
  name: '',
  company: '',
  phone: '',
  email: '',
  message: ''
})

const errors = reactive<FormErrors>({})
const loading = ref(false)
const showSuccess = ref(false)
const submitError = ref('')
const runtimeConfig = useRuntimeConfig()
const contactLocation = ref<ContactLeadLocation | null>(null)
const hasRequestedGeolocation = ref(false)

const validateEmail = (email: string): boolean => {
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
  return emailRegex.test(email)
}

const validatePhone = (phone: string): boolean => {
  const phoneRegex = /^1[3-9]\d{9}$/
  return phoneRegex.test(phone)
}

const validateForm = (): boolean => {
  let isValid = true
  
  // Reset errors
  Object.keys(errors).forEach(key => delete errors[key as keyof FormErrors])

  if (!form.name.trim()) {
    errors.name = '请输入您的姓名'
    isValid = false
  }

  if (!form.company.trim()) {
    errors.company = '请输入您的公司名称'
    isValid = false
  }

  if (!form.phone.trim()) {
    errors.phone = '请输入您的联系电话'
    isValid = false
  } else if (!validatePhone(form.phone)) {
    errors.phone = '请输入有效的手机号码'
    isValid = false
  }

  if (!form.email.trim()) {
    errors.email = '请输入您的邮箱'
    isValid = false
  } else if (!validateEmail(form.email)) {
    errors.email = '请输入有效的邮箱地址'
    isValid = false
  }

  if (!form.message.trim()) {
    errors.message = '请输入您想咨询的内容'
    isValid = false
  }

  return isValid
}

const resetForm = () => {
  form.name = ''
  form.company = ''
  form.phone = ''
  form.email = ''
  form.message = ''
}

const requestGeolocation = () => {
  if (hasRequestedGeolocation.value || !import.meta.client) {
    return
  }

  hasRequestedGeolocation.value = true

  if (!('geolocation' in navigator)) {
    return
  }

  navigator.geolocation.getCurrentPosition(
    (position) => {
      contactLocation.value = {
        lat: position.coords.latitude,
        lng: position.coords.longitude,
        accuracy: position.coords.accuracy,
        source: 'browser_geolocation',
        collectedAt: new Date(position.timestamp).toISOString()
      }
    },
    () => {
      contactLocation.value = null
    },
    {
      enableHighAccuracy: false,
      timeout: 8000,
      maximumAge: 5 * 60 * 1000
    }
  )
}

onMounted(() => {
  requestGeolocation()
})

const handleSubmit = async () => {
  if (!validateForm()) {
    return
  }

  showSuccess.value = false
  submitError.value = ''
  loading.value = true

  try {
    const supabaseUrl = runtimeConfig.public.supabaseUrl?.trim()
    const supabaseAnonKey = runtimeConfig.public.supabaseAnonKey?.trim()

    if (!supabaseUrl || !supabaseAnonKey) {
      throw new Error('提交服务未配置，请先完善 Supabase 环境变量。')
    }

    const payload = {
      name: form.name.trim(),
      company: form.company.trim(),
      phone: form.phone.trim(),
      email: form.email.trim(),
      message: form.message.trim(),
      source_page: '/contact',
      location: contactLocation.value ?? undefined
    }

    const response = await fetch(`${supabaseUrl.replace(/\/$/, '')}/functions/v1/quick-responder`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        apikey: supabaseAnonKey,
        Authorization: `Bearer ${supabaseAnonKey}`
      },
      body: JSON.stringify(payload)
    })

    const result = await response.json().catch(() => ({} as ContactLeadResponse))

    if (!response.ok || !result.success) {
      if (result.fieldErrors) {
        Object.assign(errors, result.fieldErrors)
      }

      throw new Error(result.message || '提交失败，请稍后重试。')
    }

    showSuccess.value = true
    resetForm()

    setTimeout(() => {
      showSuccess.value = false
    }, 5000)
  } catch (error) {
    submitError.value = error instanceof Error ? error.message : '提交失败，请稍后重试。'
  } finally {
    loading.value = false
  }
}
</script>
