module Pulitzer
  class PostType < ActiveRecord::Base
    has_many :posts
    has_many :post_type_content_element_types, dependent: :destroy
    has_many :content_element_types, through: :post_type_content_element_types
  end
end
