// Global Language Map
export const langMap = {
  'en': ['en-US'],
} as const

// Supported Languages
export type Language = keyof typeof langMap

// Stub locale maps (comments disabled, but components still import these)
export const giscusLocaleMap: Record<Language, string> = { 'en': 'en' }
export const twikooLocaleMap: Record<Language, string> = { 'en': 'en' }
export const walineLocaleMap: Record<Language, string> = { 'en': 'en-US' }
