module Pulitzer
  class FreeFormSectionType < ActiveRecord::Base
    belongs_to :post_type
    has_many :free_form_sections

  end
end
