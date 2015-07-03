module Pulitzer
  module PostsHelper

    def link_to_posts(post_type, plural_label='back to posts', singular_label='back to posts')
      if post_type.plural?
        link_to plural_label, posts_path(post_type_id: post_type.id)
      else
        link_to singular_label, post_path(post_type.singleton_post)
      end
    end
  end
end
