module Pulitzer
  class Style < Pulitzer::ApplicationRecord
    has_many :content_elements
    belongs_to :post_type_content_element_type
    validates :display_name, :css_class_name, presence: true

    def first?
      post_type_content_element_type.first_style.id == id
    end
  end
end
