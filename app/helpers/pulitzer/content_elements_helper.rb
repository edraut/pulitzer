module Pulitzer
  module ContentElementsHelper

    def content_element_input(content_element, f)
      send("render_#{content_element.type}_input", content_element, f)
    end

    def render_image_input(content_element, f)
      html = content_tag(:br)
      html << image_tag(content_element.image_url(:thumb)) if content_element.image_url
      html << content_tag(:div, class: 'upload-group') do
        f.file_field :image, placeholder: 'Image'
      end
      html.html_safe
    end

    def render_video_input(content_element, f)
      html = f.text_field :body, placeholder: 'Link'
      html << render_video(content_element)
      html.html_safe
    end

    def render_text_input(content_element, f)
      html = f.text_area(:body, placeholder: 'Body', data: {"rich-text-editor" => true})
      html.html_safe
    end
  end
end
