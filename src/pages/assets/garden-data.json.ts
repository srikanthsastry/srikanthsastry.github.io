import type { APIRoute } from 'astro'
import { getCollection } from 'astro:content'

export const GET: APIRoute = async () => {
  const notes = await getCollection('garden')
  const data: Record<string, {
    title: string
    maturity: string
    excerpt: string
    url: string
  }> = {}

  for (const note of notes) {
    data[note.id] = {
      title: note.data.title,
      maturity: note.data.maturity || 'seedling',
      excerpt: note.data.excerpt_text || '',
      url: `/garden/${note.id}/`,
    }
  }

  return new Response(JSON.stringify(data), {
    headers: { 'Content-Type': 'application/json' },
  })
}
