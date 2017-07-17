module Pulitzer
  class FreeFormSectionType < ActiveRecord::Base
    include Pulitzer::PostTypeElement

    belongs_to :post_type_version
    has_many :free_form_sections
    has_many :partial_types, -> { order :id }

    def first_partial_type
      partial_types.first
    end

    def clone_me
      clone_attrs = self.attributes.dup
      clone_attrs.delete 'id'
      clone_attrs.delete 'post_type_version_id'
      Pulitzer::FreeFormSectionType.new(clone_attrs)
    end

  end
end
