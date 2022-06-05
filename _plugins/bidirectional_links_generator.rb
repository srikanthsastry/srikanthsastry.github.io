# frozen_string_literal: true

class BidirectionalLinksGenerator < Jekyll::Generator
  def generate(site)
    posts = site.collections['posts'].docs

    posts.each do |current_post|
      posts_linking_to_current_post = posts.filter do |e|
        e.content.include?(current_post.url)
      end

      current_post.data['backlinks'] = posts_linking_to_current_post
    end
  end
end
