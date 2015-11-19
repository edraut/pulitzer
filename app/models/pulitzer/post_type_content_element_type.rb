module Pulitzer
  class PostTypeContentElementType < ActiveRecord::Base
    belongs_to :post_type
    belongs_to :content_element_type
    has_one :content_element
    delegate :type, :image_type?, to: :content_element_type

    default_scope { order(id: :asc) }

  end
end
