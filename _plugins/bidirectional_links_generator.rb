# frozen_string_literal: true

class BidirectionalLinksGenerator < Jekyll::Generator
  def generate(site)
    posts = site.collections['posts'].docs

    posts.each do |current_post|
      posts_linking_to_current_post = posts.filter do |e|
        # Check if the url is included, or if the post filename is included via {%post_url file-name-whithout-md-ext %}
        e.content.include?(current_post.url) || e.content.include?(File.basename(current_post.path, '.md'))
      end
      current_post.data['backlinks'] = posts_linking_to_current_post
    end
  end
end
