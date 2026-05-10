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
    favicon: '/assets/images/favicon.ico',
  },
  color: {
    mode: 'light',
    light: {
      primary: 'oklch(25% 0.02 60)',
      secondary: 'oklch(40% 0.008 60)',
      background: 'oklch(97% 0.005 85)',
      accent: 'oklch(50% 0.12 45)',
      highlight: 'oklch(0.93 0.195089 103.2532 / 0.5)',
    },
    dark: {
      primary: 'oklch(93% 0.02 85)',
      secondary: 'oklch(75% 0.008 85)',
      background: 'oklch(20% 0.005 270)',
      accent: 'oklch(70% 0.12 45)',
      highlight: 'oklch(0.93 0.195089 103.2532 / 0.2)',
    },
  },
  global: {
    locale: 'en',
    moreLocales: [],
    fontStyle: 'sans',
    dateFormat: 'MMM D YYYY',
    toc: true,
    katex: false,
    reduceMotion: false,
  },
  comment: {
    enabled: true,
    giscus: {
      repo: 'srikanthsastry/srikanthsastry.github.io',
      repoId: 'R_kgDOG4l6jA',
      category: 'Announcements',
      categoryId: 'DIC_kwDOG4l6jM4C73r_',
      mapping: 'pathname',
      strict: '0',
      reactionsEnabled: '1',
      emitMetadata: '0',
      inputPosition: 'bottom',
    },
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
