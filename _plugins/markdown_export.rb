# frozen_string_literal: true

# MarkdownExport — Jekyll plugin (post_write hook)
#
# For every post and garden note, writes a clean `.md` file alongside the
# HTML output so that AI agents can fetch raw markdown at a predictable URL
# (e.g. /the-suggestible-actor/index.md instead of /the-suggestible-actor/).
#
# The markdown file includes YAML frontmatter with title, date, tags,
# excerpt, and canonical_url, followed by the body stripped of Liquid tags.
#
# Uses :post_write so that _site/ is fully built before we add files.

Jekyll::Hooks.register :site, :post_write do |site|
  exportable = site.posts.docs +
    site.collections.fetch("garden", Jekyll::Collection.new(site, "garden")).docs

  exportable.each do |doc|
    next unless doc.data["title"]
    next unless File.exist?(doc.path)

    source = File.read(doc.path, encoding: "utf-8")
    body = extract_body(source)
    body = strip_liquid(body)

    frontmatter = build_frontmatter(doc, site)
    md_content = frontmatter + body

    # Write to _site/<url>/index.md (matching the HTML permalink structure)
    dest_dir = File.join(site.dest, doc.url)
    FileUtils.mkdir_p(dest_dir)
    dest_path = File.join(dest_dir, "index.md")
    File.write(dest_path, md_content)
  end
end

# --- helper methods at module level ---

def extract_body(source)
  if source =~ /\A---\s*\n.*?\n---\s*\n(.*)/m
    Regexp.last_match(1)
  else
    source
  end
end

def strip_liquid(text)
  text
    .gsub(/\{%.*?%\}/m, "")
    .gsub(/\{\{.*?\}\}/m, "")
    .gsub(/^\s*\n{3,}/, "\n\n") # collapse excessive blank lines left behind
end

def build_frontmatter(doc, site)
  excerpt_text = extract_excerpt(doc)

  fm = {
    "title"         => doc.data["title"],
    "date"          => format_doc_date(doc),
    "tags"          => doc.data["tags"],
    "excerpt"       => excerpt_text,
    "canonical_url" => File.join(site.config["url"].to_s, doc.url),
  }.compact

  "---\n#{fm.map { |k, v| yaml_line(k, v) }.join}\n---\n\n"
end

def format_doc_date(doc)
  date = doc.data["date"] || doc.data["created"]
  return nil unless date

  if date.is_a?(Time) || date.is_a?(DateTime)
    date.strftime("%Y-%m-%d")
  else
    date.to_s[0..9]
  end
end

def extract_excerpt(doc)
  raw = doc.data["excerpt_text"]
  raw ||= doc.data["excerpt"].to_s if doc.data["excerpt"]

  return nil if raw.nil? || raw.strip.empty?

  clean = raw.to_s.gsub(/<[^>]+>/, "").gsub(/\s+/, " ").strip

  if clean.length > 300
    clean = clean[0..300].sub(/\s\S*$/, "") + "…"
  end

  clean.empty? ? nil : clean
end

def yaml_line(key, value)
  case value
  when Array
    "#{key}:\n#{value.map { |v| "  - #{v}" }.join("\n")}\n"
  when String
    if value.include?("\n") || value.include?('"') || value.include?(":")
      "#{key}: >-\n  #{value.gsub("\n", "\n  ")}\n"
    else
      "#{key}: \"#{value}\"\n"
    end
  else
    "#{key}: #{value}\n"
  end
end
