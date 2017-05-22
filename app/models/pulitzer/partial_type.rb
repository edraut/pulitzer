module Pulitzer
  class PartialType < ActiveRecord::Base
    belongs_to :free_form_section_type
    belongs_to :post_type

    def first?
      free_form_section_type.first_partial_type.id == id
    end
  end
end
