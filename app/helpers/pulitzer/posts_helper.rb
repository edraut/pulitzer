module Pulitzer
  module PostsHelper

    def link_to_posts(post_type, plural_label, singular_label)
      if post_type.plural?
        link_to plural_label, posts_path(post_type_id: post_type.id)
      else
        link_to singular_label, post_content_elements_edit_multiple_path(post_type.singleton_post)
      end
    end

    def link_back_to_posts(post_type, plural_label='back to posts', singular_label='back to posts')
      if post_type.plural?
        link_to plural_label, posts_path(post_type_id: post_type.id)
      else
        link_to singular_label, post_types_path
      end
    end

    def render_video(element)
      if element.video_link
        content_tag(:iframe, nil, src: element.video_link)
      end
    end
  end
end
