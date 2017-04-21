module Pulitzer
  module ContentElementHelper

    def render_cms_element(element,options = {})
      if element.image_type?
        render_image(element,options)
      elsif element.video_type?
        render_video(element,options)
      else
        render_body(element,options)
      end
    end

    def render_image(element,options = {})
      pulitzer_options = {'data-pulitzer-element' => element.id}
      if options.is_a? Hash
        pulitzer_options.merge!(options)
      end
      image_tag element.image_url(:cms), pulitzer_options
    end

    def render_picture_source(element,options = {})
      content_tag(:source, nil, options.merge(srcset: element.image_url(:cms)))
    end

    def render_img_srcset(element,options = {})
      content_tag(:img, nil, options.merge(srcset: element.image_url(:cms)))
    end

    def render_cms_image_path(element,options = {})
      element.image_url(:cms)
    end

    def render_video(element, options = {})
      content_tag(:iframe, nil, options.merge(src: element.video_link)) if element.video_link
    end

    def render_body(element, options = {})
      content_tag(:span, element.body.html_safe, options) if element.body
    end

    def render_cms_html(element, options = {})
      content_tag(:span, element.html, options) if element.html
    end

    def render_cms_url(element, options ={})
       element.body.html_safe if element.html
    end

    def render_cms_section(version, section_name)
      version.section(section_name).partials.collect do |partial|
        render partial: partial.full_view_path, locals: {partial: partial}
      end.join.html_safe
    end
  end
end
