module Pulitzer
  class Post < ActiveRecord::Base
    belongs_to :post_type
    has_many :content_elements, dependent: :destroy
    has_many :post_tags, dependent: :destroy
    has_many :tags, through: :post_tags
    delegate :post_type_content_element_types, to: :post_type

    def content_element(label)
      self.content_elements.find_by(label: label)
    end

  end
end
