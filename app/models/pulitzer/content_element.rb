module Pulitzer
  class ContentElement < ActiveRecord::Base
    belongs_to :post
    belongs_to :content_element_type
    mount_uploader :image, Pulitzer::ImageUploader
    delegate :type, :image_type?, to: :content_element_type
  end
end
