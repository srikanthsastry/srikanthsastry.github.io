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
// Fonts are local to avoid network fetch at build time (api.fontsource.org timeouts in offline Hatch spaces)
// astro-og-canvas defaults to fetching Noto Sans from fontsource CDN; we override via local TTFs.
// eslint-disable-next-line antfu/no-top-level-await
export const { getStaticPaths, GET } = await OGImageRoute({
  param: 'image',
  pages,
  getImageOptions: (_path, page) => ({
    title: page.title,
    description: page.description,
    // Local fonts: must be listed here (inside getImageOptions) so they override the default remote URL
    fonts: [
      './public/fonts/NotoSans-Regular.ttf',
      './public/fonts/NotoSans-Bold.ttf',
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
