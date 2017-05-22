module Pulitzer
  class FreeFormSectionType < ActiveRecord::Base
    include Pulitzer::PostTypeElement

    belongs_to :post_type
    has_many :free_form_sections
    has_many :partial_types, -> { order :id }

    def first_partial_type
      partial_types.first
    end

  end
end
