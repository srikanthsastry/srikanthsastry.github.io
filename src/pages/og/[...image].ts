import type { CollectionEntry } from 'astro:content'
import { OGImageRoute } from 'astro-og-canvas'
import { getCollection } from 'astro:content'
import { getPostDescription } from '@/utils/description'

// eslint-disable-next-line antfu/no-top-level-await
const posts = await getCollection('posts')

// Create slug-to-metadata lookup object for blog posts
const pages = Object.fromEntries(
  posts.map((post: CollectionEntry<'posts'>) => [
    post.id,
    {
      title: post.data.title,
      description: getPostDescription(post, 'og'),
    },
  ]),
)

// Configure Open Graph image generation route
// Fonts are local via @fontsource/noto-sans to avoid network fetch at build time (api.fontsource.org timeouts in offline Hatch spaces)
// astro-og-canvas defaults to fetching Noto Sans from fontsource CDN; we override via versioned npm package.
// eslint-disable-next-line antfu/no-top-level-await
export const { getStaticPaths, GET } = await OGImageRoute({
  param: 'image',
  pages,
  getImageOptions: (_path, page) => ({
    title: page.title,
    description: page.description,
    // Local fonts from @fontsource/noto-sans (woff) - versioned, offline, no remote fetch
    fonts: [
      './node_modules/@fontsource/noto-sans/files/noto-sans-latin-400-normal.woff',
      './node_modules/@fontsource/noto-sans/files/noto-sans-latin-700-normal.woff',
    ],
    logo: {
      path: './public/icons/og-logo.png', // Required local path and PNG format
      size: [250],
    },
    border: {
      color: [242, 241, 245],
      width: 20,
    },
    font: {
      title: {
        families: ['Noto Sans'],
        weight: 'Bold',
        color: [34, 33, 36],
        lineHeight: 1.5,
      },
      description: {
        families: ['Noto Sans'],
        color: [72, 71, 74],
        lineHeight: 1.5,
      },
    },
    bgGradient: [[242, 241, 245]],
  }),
})
