module Pulitzer
  class ContentElement < ActiveRecord::Base
    mount_uploader :image, Pulitzer::ImageUploader
    belongs_to :post
    belongs_to :content_element_type
    belongs_to :post_type_content_element_type
    delegate :type, :text_type?, :image_type?, :video_type?, to: :content_element_type
    delegate :height, :width, to: :post_type_content_element_type
    default_scope { order(id: :asc) }

    def video_link
      if video_type? && !body.nil?
        vimeo_video(body) || youtube_video(body)
      end
    end

    def html
      body.html_safe if body
    end

    def empty_body?
      image_type? ? !image? : body.blank?
    end

private
    def vimeo_video(element)
      if element.match(/vimeo/) && code = element.split("/").last
        "https://player.vimeo.com/video/#{code}"
      end
    end

    def youtube_video(element)
      if element.match(/youtube/) && code = element.split("=").last
        "https://www.youtube.com/embed/#{code}"
      end
    end

  end
end
