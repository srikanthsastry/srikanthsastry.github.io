# frozen_string_literal: true

# MarkdownExport — Jekyll Generator plugin
#
# For every post and garden note, writes a clean `.md` file alongside the
# HTML output so that AI agents can fetch raw markdown at a predictable URL
# (e.g. /the-suggestible-actor/index.md instead of /the-suggestible-actor/).
#
# The markdown file includes YAML frontmatter with title, date, tags,
# excerpt, and canonical_url, followed by the body stripped of Liquid tags.

module Jekyll
  class MarkdownExport < Generator
    safe true
    priority :lowest  # run after everything else has been generated

    def generate(site)
      exportable = site.posts.docs + site.collections.fetch("garden", Jekyll::Collection.new(site, "garden")).docs

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

        # Register as a static file so Jekyll doesn't clean it up
        site.static_files << StaticFile.new(
          site, site.dest, doc.url, "index.md"
        )
      end
    end

    private

    # Extract everything after the closing --- of YAML frontmatter
    def extract_body(source)
      if source =~ /\A---\s*\n.*?\n---\s*\n(.*)/m
        Regexp.last_match(1)
      else
        source
      end
    end

    # Strip Liquid template tags: {% ... %} and {{ ... }}
    def strip_liquid(text)
      text
        .gsub(/\{%.*?%\}/m, "")
        .gsub(/\{\{.*?\}\}/m, "")
        .gsub(/^\s*\n{3,}/, "\n\n")  # collapse excessive blank lines left behind
    end

    def build_frontmatter(doc, site)
      excerpt_text = extract_excerpt(doc)

      fm = {
        "title"         => doc.data["title"],
        "date"          => format_date(doc),
        "tags"          => doc.data["tags"],
        "excerpt"       => excerpt_text,
        "canonical_url" => File.join(site.config["url"].to_s, doc.url),
      }.compact

      "---\n#{fm.map { |k, v| yaml_line(k, v) }.join}\n---\n\n"
    end

    def format_date(doc)
      date = doc.data["date"] || doc.data["created"]
      return nil unless date

      if date.is_a?(Time) || date.is_a?(DateTime)
        date.strftime("%Y-%m-%d")
      else
        date.to_s[0..9]  # "2026-04-24" from string or Date
      end
    end

    def extract_excerpt(doc)
      # Prefer explicit excerpt_text frontmatter (garden notes use this)
      raw = doc.data["excerpt_text"]

      # Fall back to Jekyll's auto-generated excerpt
      raw ||= doc.data["excerpt"].to_s if doc.data["excerpt"]

      return nil if raw.nil? || raw.strip.empty?

      # Strip HTML tags (Jekyll sometimes renders excerpts)
      clean = raw.to_s.gsub(/<[^>]+>/, "").gsub(/\s+/, " ").strip

      # Truncate to ~300 chars at a word boundary
      if clean.length > 300
        clean = clean[0..300].sub(/\s\S*$/, "") + "…"
      end

      clean.empty? ? nil : clean
    end

    # Simple YAML serialization for frontmatter lines
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
  end
end
