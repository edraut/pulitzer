class Pulitzer::TextEditor < ActiveRecord::Base
  has_many :post_type_content_element_types
end
