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

    def render_cms_title(element, options = {})
      content_tag(:span, element.title, options) if element.title
    end

    def render_cms_html(element, options = {})
      content_tag(:span, element.html, options) if element.html
    end
  end
end
