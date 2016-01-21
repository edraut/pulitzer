module Pulitzer
  class ContentElement < ActiveRecord::Base
    mount_uploader :image, Pulitzer::ImageUploader
    enum kind: [ :template, :free_form ]

    # Associations
    belongs_to :version
    belongs_to :content_element_type
    belongs_to :post_type_content_element_type
    delegate :type, :text_type?, :image_type?, :video_type?, to: :content_element_type
    delegate :post, to: :version

    attr_accessor :version_unavailable

    # Validations
    validates :label, presence: true, uniqueness: { scope: :version_id }, unless: :free_form?

    # Callbacks
    before_save :handle_sort_order

    # Scopes
    default_scope { order(id: :asc) }
    scope :free_form, -> { where(kind: kinds[:free_form]).reorder(sort_order: :asc) }

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
      image_type? ? !image? : body.blank?
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
          if my_clone.errors.get(:image).any?
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
      if new_record? && sort_order.nil? && free_form?
        self.sort_order = version.free_form_content_elements.maximum(:sort_order).to_i + 1
      end
    end

  end
end
