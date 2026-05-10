import { glob } from 'astro/loaders'
import { z } from 'astro/zod'
import { defineCollection } from 'astro:content'
import { allLocales, themeConfig } from '@/config'

const posts = defineCollection({
  loader: glob({ pattern: '**/*.{md,mdx}', base: './src/content/posts' }),
  schema: z.object({
    // required
    title: z.string(),
    published: z.coerce.date(),
    // optional
    description: z.string().optional().default(''),
    excerpt: z.string().optional().default(''),
    categories: z.array(z.string()).optional().default([]),
    updated: z.preprocess(
      val => val === '' ? undefined : val,
      z.date().optional(),
    ),
    tags: z.array(z.string()).optional().default([]),
    // Advanced
    draft: z.boolean().optional().default(false),
    pin: z.number().int().min(0).max(99).optional().default(0),
    toc: z.boolean().optional().default(themeConfig.global.toc),
    lang: z.enum(['', ...allLocales]).optional().default(''),
    abbrlink: z.string().optional().default('').refine(
      abbrlink => !abbrlink || /^[a-z0-9\-]*$/.test(abbrlink),
      { message: 'Abbrlink can only contain lowercase letters, numbers and hyphens' },
    ),
    image: z.string().optional(),
    // Series navigation
    series: z.string().optional(),
    series_order: z.number().int().optional(),
    series_label: z.string().optional(),
    series_section: z.string().optional(),
  }),
})

const garden = defineCollection({
  loader: glob({ pattern: '**/*.{md,mdx}', base: './src/content/garden' }),
  schema: z.object({
    title: z.string(),
    maturity: z.enum(['evergreen', 'budding', 'seedling']).default('seedling'),
    tags: z.array(z.string()).optional().default([]),
    created: z.coerce.date(),
    related_notes: z.array(z.string()).optional().default([]),
    related_posts: z.array(z.string()).optional().default([]),
    excerpt_text: z.string().optional().default(''),
    garden_type: z.string().optional().default('note'),
  }),
})

const about = defineCollection({
  loader: glob({ pattern: '**/*.{md,mdx}', base: './src/content/about' }),
  schema: z.object({
    lang: z.enum(['', ...allLocales]).optional().default(''),
  }),
})

export const collections = { posts, about, garden }
