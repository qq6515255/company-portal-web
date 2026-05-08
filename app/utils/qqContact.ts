export const QQ_NUMBER = '1322805852'

export const QQ_WEB_CHAT_URL = `https://wpa.qq.com/msgrd?v=3&uin=${QQ_NUMBER}&site=qq&menu=yes`
export const QQ_APP_CHAT_URL = `tencent://message/?uin=${QQ_NUMBER}&Site=顺泰包装&Menu=yes`

export function openQqChat() {
  if (!import.meta.client) {
    return
  }

  window.location.href = QQ_APP_CHAT_URL

  window.setTimeout(() => {
    window.open(QQ_WEB_CHAT_URL, '_blank', 'noopener')
  }, 600)
}
