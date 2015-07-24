module Pulitzer
  class ContentElementType < ActiveRecord::Base
    has_many :post_type_content_element_types, dependent: :destroy

    def type
      name.downcase.to_sym
    end

    %i(text image video).each do |content_type|
      define_method "#{content_type}_type?" do
        type == content_type
      end
    end
  end
end
