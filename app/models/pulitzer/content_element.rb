module Pulitzer
  class ContentElement < ActiveRecord::Base
    mount_uploader :image, Pulitzer::ImageUploader
    belongs_to :post
    belongs_to :content_element_type
    belongs_to :post_type_content_element_type
    delegate :type, :image_type?, to: :content_element_type
    delegate :height, :width, to: :post_type_content_element_type
    default_scope { order(id: :asc) }
  end
end
