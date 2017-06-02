module Pulitzer
  class ContentElementType < ActiveRecord::Base
    validates :name, presence: true, uniqueness: true
    has_many :post_type_content_element_types, dependent: :destroy
    has_many :layouts, dependent: :destroy

    def type
      name.downcase.to_sym
    end

    %i(text image video clickable).each do |content_type|
      define_method "#{content_type}_type?" do
        type == content_type
      end
    end

    def has_styles?
      [:clickable].include? type
    end
  end
end
