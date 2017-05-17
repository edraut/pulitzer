module Pulitzer
  class FreeFormSectionType < ActiveRecord::Base
    include Pulitzer::PostTypeElement

    belongs_to :post_type_version
    has_many :free_form_sections
    has_many :partial_types

  end
end
