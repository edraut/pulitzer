module Pulitzer
  class ContentElement < ActiveRecord::Base
    belongs_to :post
    belongs_to :content_element_type
    mount_uploader :body, Pulitzer::ImageUploader, if: :image_type?

    def type
      self.content_element_type.name.downcase.to_sym
    end

    def image_type?
      self.type == :image
    end
  end
end
