module Pulitzer
  class ContentElementType < ActiveRecord::Base
    has_many :post_type_content_element_types, dependent: :destroy
  end
end
