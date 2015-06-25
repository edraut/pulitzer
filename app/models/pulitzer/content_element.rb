module Pulitzer
  class ContentElement < ActiveRecord::Base
    belongs_to :post
    belongs_to :content_element_type

    def type
      self.content_element_type.name.to_sym
    end
  end
end
