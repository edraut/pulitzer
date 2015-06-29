module Pulitzer
  module ApplicationHelper

    def link_to_post_type(post_type)
      if post_type.plural?
        link_to "Index", posts_path(post_type_id: post_type.id)
      else
        link_to "Manage", '#'
      end
    end
  end
end
