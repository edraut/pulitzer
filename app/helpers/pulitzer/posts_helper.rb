module Pulitzer
  module PostsHelper

    def link_to_posts(post_type, plural_label, singular_label)
      if post_type.plural?
        ajax_link plural_label, posts_path(post_type_id: post_type.id), {}, '[data-tab-id="templates"]'
      else
        ajax_link singular_label, edit_post_path(post_type.singleton_post), {}, '[data-tab-id="templates"]'
      end
    end

    def link_back_to_posts(post_type, plural_label, singular_label)
      if post_type.plural?
        ajax_link plural_label, pulitzer.posts_path(post_type_id: post_type.id), {}, '[data-tab-id="templates"]'
      else
        ajax_link singular_label, pulitzer.post_types_path, {}, '[data-tab-id="templates"]'
      end
    end

    def render_video(element)
      content_tag(:iframe, nil, src: element.video_link) if element.video_link
    end

    def render_clickable(element)
      content_tag(:span, 'clickabe text:&nbsp'.html_safe, class: 'pulitzer-span heading') +
      content_tag(:span, element.title, class: 'pulitzer-span margin') +
      content_tag(:span, 'action:&nbsp;'.html_safe, class: 'pulitzer-span heading') +
      content_tag(:span, element.content_display, class: 'pulitzer-span margin') +
      content_tag(:span, 'style:&nbsp;'.html_safe, class: 'pulitzer-span heading') +
      content_tag(:span, element.style_display, class: 'pulitzer-span margin')
    end

    def render_element(element)
      if element.image_type?
        image_tag(element.image_url(:thumb)) if element.image?
      elsif element.video_type?
        render_video(element)
      elsif element.clickable_type?
        render_clickable(element)
      else
        element.body.html_safe if element.body
      end
    end

    def humanize_class_name(klass)
      underscore_class_name(klass).humanize
    end

    def underscore_class_name(klass)
      klass.delete(":").underscore
    end

    def select2_html_options(tag_model)
      { class: 'seletct2-pulitzer-tags', data: { select2_trigger: true } }
    end
  end
end
