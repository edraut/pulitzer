module Pulitzer
  class PostTypeContentElementType < ActiveRecord::Base
    belongs_to :post_type
    belongs_to :content_element_type
  end
end
