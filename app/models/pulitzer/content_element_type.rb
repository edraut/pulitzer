module Pulitzer
  class ContentElementType < ActiveRecord::Base
    has_many :post_type_content_element_types, dependent: :destroy

    def type
      name.downcase.to_sym
    end

    def image_type?
      type == :image
    end
  end
end
