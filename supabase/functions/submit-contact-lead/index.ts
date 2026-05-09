import nodemailer from 'npm:nodemailer@6.10.1'

const phoneRegex = /^1[3-9]\d{9}$/
const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/

function getAllowedOrigins() {
  const configuredOrigins = (Deno.env.get('CONTACT_ALLOWED_ORIGIN') || '')
    .split(',')
    .map((item) => item.trim())
    .filter(Boolean)

  const defaultOrigins = [
    'http://localhost:3000',
    'http://127.0.0.1:3000',
    'https://suntaizh.cn',
    'https://www.suntaizh.cn'
  ]

  return [...new Set([...configuredOrigins, ...defaultOrigins])]
}

function getCorsHeaders(request) {
  const requestOrigin = request.headers.get('origin') || ''
  const allowedOrigins = getAllowedOrigins()
  const allowOrigin = allowedOrigins.includes(requestOrigin) ? requestOrigin : allowedOrigins[0] || '*'

  return {
    'Access-Control-Allow-Origin': allowOrigin,
    'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
    'Access-Control-Allow-Methods': 'POST, OPTIONS',
    'Access-Control-Allow-Credentials': 'true',
    'Vary': 'Origin',
    'Content-Type': 'application/json'
  }
}

function jsonResponse(request, status, body) {
  return new Response(JSON.stringify(body), {
    status,
    headers: getCorsHeaders(request)
  })
}

function sanitizeText(value, maxLength) {
  if (typeof value !== 'string') {
    return ''
  }

  return value.trim().slice(0, maxLength)
}

function sanitizeLocation(location) {
  if (!location || typeof location !== 'object') {
    return null
  }

  const lat = typeof location.lat === 'number' ? location.lat : Number.NaN
  const lng = typeof location.lng === 'number' ? location.lng : Number.NaN

  if (!Number.isFinite(lat) || lat < -90 || lat > 90) {
    return null
  }

  if (!Number.isFinite(lng) || lng < -180 || lng > 180) {
    return null
  }

  const accuracy =
    typeof location.accuracy === 'number' && Number.isFinite(location.accuracy) && location.accuracy >= 0
      ? location.accuracy
      : undefined

  const collectedAt = sanitizeText(location.collectedAt, 64)
  const parsedCollectedAt = collectedAt ? new Date(collectedAt) : null

  return {
    lat,
    lng,
    accuracy,
    source: 'browser_geolocation',
    collectedAt:
      parsedCollectedAt && !Number.isNaN(parsedCollectedAt.getTime())
        ? parsedCollectedAt.toISOString()
        : undefined,
    address: sanitizeText(location.address, 255) || undefined
  }
}

function validatePayload(payload) {
  const fieldErrors = {}
  const name = sanitizeText(payload?.name, 100)
  const company = sanitizeText(payload?.company, 120)
  const phone = sanitizeText(payload?.phone, 32)
  const email = sanitizeText(payload?.email, 254)
  const message = sanitizeText(payload?.message, 4000)
  const sourcePage = sanitizeText(payload?.source_page, 255) || '/contact'

  if (!name) {
    fieldErrors.name = '请输入您的姓名'
  }

  if (!company) {
    fieldErrors.company = '请输入您的公司名称'
  }

  if (!phone) {
    fieldErrors.phone = '请输入您的联系电话'
  } else if (!phoneRegex.test(phone)) {
    fieldErrors.phone = '请输入有效的手机号码'
  }

  if (!email) {
    fieldErrors.email = '请输入您的邮箱'
  } else if (!emailRegex.test(email)) {
    fieldErrors.email = '请输入有效的邮箱地址'
  }

  if (!message) {
    fieldErrors.message = '请输入您想咨询的内容'
  }

  if (Object.keys(fieldErrors).length > 0) {
    return { fieldErrors }
  }

  return {
    fieldErrors,
    payload: {
      name,
      company,
      phone,
      email,
      message,
      sourcePage,
      location: sanitizeLocation(payload?.location)
    }
  }
}

async function insertLead(payload) {
  const supabaseUrl = Deno.env.get('SUPABASE_URL')
  const serviceRoleKey = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')

  if (!supabaseUrl || !serviceRoleKey) {
    throw new Error('缺少 Supabase 服务端环境变量。')
  }

  const response = await fetch(`${supabaseUrl}/rest/v1/contact_leads?select=id`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      apikey: serviceRoleKey,
      Authorization: `Bearer ${serviceRoleKey}`,
      Prefer: 'return=representation'
    },
    body: JSON.stringify({
      name: payload.name,
      company: payload.company,
      phone: payload.phone,
      email: payload.email,
      message: payload.message,
      source_page: payload.sourcePage,
      status: 'new',
      location_lat: payload.location?.lat ?? null,
      location_lng: payload.location?.lng ?? null,
      location_accuracy: payload.location?.accuracy ?? null,
      location_source: payload.location?.source ?? null,
      location_collected_at: payload.location?.collectedAt ?? null,
      location_address: payload.location?.address ?? null
    })
  })

  if (!response.ok) {
    const errorText = await response.text()
    throw new Error(`线索写入失败: ${errorText}`)
  }

  const data = await response.json()
  const lead = Array.isArray(data) ? data[0] : data
  return lead?.id
}

function formatLocation(location) {
  if (!location || typeof location.lat !== 'number' || typeof location.lng !== 'number') {
    return '未提供'
  }

  const parts = [
    `纬度: ${location.lat}`,
    `经度: ${location.lng}`
  ]

  if (typeof location.accuracy === 'number') {
    parts.push(`精度: ${location.accuracy} 米`)
  }

  if (location.collectedAt) {
    parts.push(`采集时间: ${location.collectedAt}`)
  }

  return parts.join('\n')
}

function escapeHtml(value) {
  return String(value)
    .replaceAll('&', '&amp;')
    .replaceAll('<', '&lt;')
    .replaceAll('>', '&gt;')
    .replaceAll('"', '&quot;')
    .replaceAll("'", '&#39;')
}

async function sendNotificationEmail(payload) {
  const smtpHost = Deno.env.get('SMTP_HOST') || 'smtp.qq.com'
  const smtpPort = Number(Deno.env.get('SMTP_PORT') || '465')
  const smtpUser = Deno.env.get('SMTP_USER')
  const smtpPassword = Deno.env.get('SMTP_PASSWORD')
  const notifyTo = Deno.env.get('CONTACT_NOTIFY_TO_EMAIL')
  const notifyFrom = Deno.env.get('CONTACT_NOTIFY_FROM_EMAIL') || smtpUser

  if (!smtpUser || !smtpPassword || !notifyTo || !notifyFrom) {
    throw new Error('缺少邮件通知环境变量。')
  }

  const locationText = formatLocation(payload.location)
  const subject = `新客户咨询 | ${payload.company} - ${payload.name}`
  const text = [
    '官网收到一条新的客户咨询：',
    '',
    `姓名: ${payload.name}`,
    `公司: ${payload.company}`,
    `手机: ${payload.phone}`,
    `邮箱: ${payload.email}`,
    `来源页面: ${payload.sourcePage || '/contact'}`,
    '',
    '咨询内容:',
    payload.message,
    '',
    '位置:',
    locationText
  ].join('\n')

  const html = `
    <div style="font-family:Arial,sans-serif;color:#064E3B;line-height:1.6;">
      <h2 style="margin-bottom:16px;">官网收到一条新的客户咨询</h2>
      <p><strong>姓名:</strong> ${escapeHtml(payload.name)}</p>
      <p><strong>公司:</strong> ${escapeHtml(payload.company)}</p>
      <p><strong>手机:</strong> ${escapeHtml(payload.phone)}</p>
      <p><strong>邮箱:</strong> ${escapeHtml(payload.email)}</p>
      <p><strong>来源页面:</strong> ${escapeHtml(payload.sourcePage || '/contact')}</p>
      <p><strong>咨询内容:</strong></p>
      <pre style="white-space:pre-wrap;background:#ECFDF5;padding:12px;border-radius:6px;">${escapeHtml(payload.message)}</pre>
      <p><strong>位置:</strong></p>
      <pre style="white-space:pre-wrap;background:#F9FAFB;padding:12px;border-radius:6px;">${escapeHtml(locationText)}</pre>
    </div>
  `

  const transporter = nodemailer.createTransport({
    host: smtpHost,
    port: smtpPort,
    secure: smtpPort === 465,
    auth: {
      user: smtpUser,
      pass: smtpPassword
    }
  })

  await transporter.sendMail({
    from: notifyFrom,
    to: notifyTo,
    subject,
    text,
    html
  })
}

Deno.serve(async (request) => {
  if (request.method === 'OPTIONS') {
    return new Response('ok', { status: 200, headers: getCorsHeaders(request) })
  }

  if (request.method !== 'POST') {
    return jsonResponse(request, 405, { success: false, message: 'Method Not Allowed' })
  }

  try {
    const body = await request.json()
    const result = validatePayload(body)

    if (!result.payload) {
      return jsonResponse(request, 400, {
        success: false,
        message: '表单校验失败，请检查填写内容。',
        fieldErrors: result.fieldErrors
      })
    }

    const leadId = await insertLead(result.payload)
    await sendNotificationEmail(result.payload)

    return jsonResponse(request, 200, {
      success: true,
      leadId
    })
  } catch (error) {
    console.error('[submit-contact-lead] failed', error)

    return jsonResponse(request, 500, {
      success: false,
      message: '提交失败，请稍后重试。'
    })
  }
})
