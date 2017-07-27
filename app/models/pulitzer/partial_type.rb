module Pulitzer
  class PartialType < Pulitzer::ApplicationRecord
    belongs_to :free_form_section_type
    belongs_to :post_type_version

    def self.export_config
      { except: :id }
    end

    def first?
      free_form_section_type.first_partial_type.id == id
    end
  end
end
