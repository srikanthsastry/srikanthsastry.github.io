import type { ThemeConfig } from '@/types'

export const themeConfig: ThemeConfig = {
  site: {
    title: 'Srikanth Sastry',
    subtitle: '',
    description: 'Personal blog — technology, programming, governance, and life.',
    i18nTitle: false,
    author: 'Srikanth Sastry',
    url: 'https://srikanth.sastry.name',
    base: '/',
    favicon: '/icons/favicon.svg',
  },
  color: {
    mode: 'light',
    light: {
      primary: 'oklch(25% 0.005 298)',
      secondary: 'oklch(40% 0.005 298)',
      background: 'oklch(96% 0.005 298)',
      highlight: 'oklch(0.93 0.195089 103.2532 / 0.5)',
    },
    dark: {
      primary: 'oklch(92% 0.005 298)',
      secondary: 'oklch(77% 0.005 298)',
      background: 'oklch(22% 0.005 298)',
      highlight: 'oklch(0.93 0.195089 103.2532 / 0.2)',
    },
  },
  global: {
    locale: 'en',
    moreLocales: [],
    fontStyle: 'serif',
    dateFormat: 'MMM D YYYY',
    toc: true,
    katex: false,
    reduceMotion: false,
  },
  comment: {
    enabled: false,
  },
  seo: {
    twitterID: '',
    verification: {
      google: '',
      bing: '',
      yandex: '',
      baidu: '',
    },
    googleAnalyticsID: '',
    umamiAnalyticsID: '',
    folo: {
      feedID: '',
      userID: '',
    },
    apiflashKey: '',
  },
  footer: {
    links: [
      {
        name: 'RSS',
        url: '/atom.xml',
      },
      {
        name: 'GitHub',
        url: 'https://github.com/srikanthsastry',
      },
      {
        name: 'Email',
        url: 'srikanth@sastry.name',
      },
      {
        name: 'Threads',
        url: 'https://www.threads.com/@sri.sastry',
      },
      {
        name: 'LinkedIn',
        url: 'https://www.linkedin.com/in/srikanthsastry/',
      },
    ],
    startYear: 2007,
  },
  preload: {
    imageHostURL: '',
    customGoogleAnalyticsJS: '',
    customUmamiAnalyticsJS: '',
  },
}

export const base = themeConfig.site.base === '/' ? '' : themeConfig.site.base.replace(/\/$/, '')
export const defaultLocale = themeConfig.global.locale
export const moreLocales = themeConfig.global.moreLocales
export const allLocales = [defaultLocale, ...moreLocales]
