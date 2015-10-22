module Pulitzer
  module PostsHelper

    def link_to_posts(post_type, plural_label, singular_label)
      if post_type.plural?
        link_to plural_label, posts_path(post_type_id: post_type.id)
      else
        link_to singular_label, post_content_elements_path(post_type.singleton_post)
      end
    end

    def link_back_to_posts(post_type, plural_label, singular_label)
      if post_type.plural?
        link_to plural_label, posts_path(post_type_id: post_type.id)
      else
        link_to singular_label, post_types_path
      end
    end

    def render_video(element)
      content_tag(:iframe, nil, src: element.video_link) if element.video_link
    end

    def render_element(element)
      if element.image_type?
        image_tag element.image_url(:thumb)
      elsif element.video_type?
        render_video(element)
      else
        element.body.html_safe
      end
    end

    def humanize_class_name(klass)
      underscore_class_name(klass).humanize
    end

    def underscore_class_name(klass)
      klass.delete(":").underscore
    end

    def select2_html_options(tag_model)
      if tag_model == "Pulitzer::Tag"
        { class: 'seletct2-pulitzer-tags', data: { select2_trigger: true } }
      else
        { }
      end
    end
  end
end
