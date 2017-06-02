module Pulitzer
  class ContentElement < ActiveRecord::Base
    mount_uploader :image, Pulitzer::ImageUploader

    # Associations
    belongs_to :version
    belongs_to :content_element_type
    belongs_to :post_type_content_element_type
    belongs_to :style
    belongs_to :custom_option

    delegate :type, :text_type?, :image_type?, :video_type?, :clickable_type?, to: :content_element_type
    delegate :required?, :sort_order, :custom_option_list, :custom_options, :any_clickable_kind?,
      :url_clickable_kind?, :clickable_kinds, :custom_clickable_kinds,
      to: :post_type_content_element_type, allow_nil: true
    delegate :post, to: :version

    attr_accessor :version_unavailable, :ensure_unique

    # Validations
    validates_with ContentElementValidator

    # Callbacks
    before_save :handle_sort_order

    # Scopes
    default_scope { order(id: :asc) }
    scope :required, -> { joins(:post_type_content_element_type).where(pulitzer_post_type_content_element_types: { required: true}) }

    # def reprocess_versions
    #   ReprocessContentImageJob.perform_later(self)
    # end

    # def reprocess_versions!
    #   self.photo.recreate_versions!
    #   self.broadcast_change
    # end

    def video_link
      if video_type? && !body.nil?
        vimeo_video(body) || youtube_video(body)
      end
    end

    def html
      body.blank? ? "" : body.html_safe
    end

    def empty_body?
      !has_content?
    end

    def has_content?
      if image_type?
        image?
      elsif custom_type?
        custom_content.present?
      else
        body.present?
      end
    end

    def custom_content
      custom_option.value
    end

    def custom_display
      "#{custom_option.display} #{custom_option.custom_option_list.name.singularize}"
    end

    def content
      if custom_type?
        custom_content
      else
        body
      end
    end

    def content_display
      if custom_type?
        custom_display
      else
        body
      end
    end

    def custom_type?
      custom_option.present?
    end

    def clickable_kind
      if custom_type?
        custom_option.custom_option_list
      elsif body.present?
        Pulitzer::PostTypeContentElementType.url_clickable
      else
        Pulitzer::PostTypeContentElementType.any_clickable
      end
    end

    def style_options
      post_type_content_element_type.styles
    end

    def style_display
      style.display_name
    end

    def clone_me
      clone_attrs = self.attributes.dup
      clone_attrs.delete 'id'
      clone_attrs.delete 'version_id'

      type_clone_method = 'clone_' + type.to_s

      if respond_to? type_clone_method
        my_clone = send type_clone_method, clone_attrs
      else
        my_clone = Pulitzer::ContentElement.create!(clone_attrs)
      end
      my_clone
    end

    def clone_image(clone_attrs)
      clone_attrs.delete 'image'
      my_clone = Pulitzer::ContentElement.new(clone_attrs)
      if image.file && image.file.exists?
        my_clone.remote_image_url = image.url
        # If there is an error getting the image, don't bail out,
        # create the content element clone without the image so the user can reupload later
        if !my_clone.valid?
          if my_clone.errors.get(:image)
            my_clone = Pulitzer::ContentElement.new(clone_attrs)
          end
        end
      end
      my_clone.save!
      my_clone
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

    def handle_sort_order
      if new_record? && sort_order.nil? && version.present?
        self.sort_order = version.content_elements.maximum(:sort_order).to_i + 1
      end
    end

  end
end
