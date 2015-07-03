module Pulitzer
  module PostsHelper

    def link_to_post_type(post_type)
      if post_type.plural?
        link_to "Index", posts_path(post_type_id: post_type.id)
      else
        link_to "Manage", '#'
      end
    end

    def link_back_to_post(post)
      if post.post_type.plural?
        link_to "Back to post", posts_path(post_type_id: post.post_type.id)
      else
        link_to "Back to post", '#'
      end
    end
  end
end
