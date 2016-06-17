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
      if is_preview?
        render(partial: '/pulitzer/content_elements/image_context', locals: {element: element, options: options})
      else
        image_tag element.image_url(:cms), options
      end
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
      if is_preview?
        render(partial: '/pulitzer/content_elements/video_context', locals: {element: element, options: options})
      else
        content_tag(:iframe, nil, options.merge(src: element.video_link)) if element.video_link
      end
    end

    def render_body(element, options = {})
      if is_preview?
        render(partial: '/pulitzer/content_elements/body_context', locals: {element: element, options: options}) if element.body
      else
        element.body.html_safe if element.body
      end
    end

    def render_cms_html(element, options = {})
      content_tag(:span, element.html, pulitzer_options(element,options)) if element.html
    end

    def render_cms_url(element, options ={})
       element.body.html_safe if element.html
    end

    def render_cms_section(post_type, section_name)
      post_type.section(section_name).partials.collect do |partial|
        render partial: partial.full_view_path, locals: {partial: partial}
      end.join.html_safe
    end

    def pulitzer_options(element,options)
      pulitzer_options = {'data-context-editor' => main_app.pulitzer_path + pulitzer.edit_content_element_path(element, edit_mode: 'context')}
      if options.is_a? Hash
        pulitzer_options.merge!(options)
      end
      pulitzer_options
    end

    def pulitzer_options_string(element,options)
      pulitzer_options(element,options).map{|k,v|
        ' ' + k.to_s + '="' + v + '" '
      }.join.html_safe
    end

    def is_preview?
      (request.path.split('/')[1] == 'pulitzer_preview') ||
      'context' == params[:edit_mode]
    end
  end
end
