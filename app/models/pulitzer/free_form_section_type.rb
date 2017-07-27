module Pulitzer
  class FreeFormSectionType < Pulitzer::ApplicationRecord
    include Pulitzer::PostTypeElement

    belongs_to :post_type_version
    has_many :free_form_sections
    has_many :partial_types, -> { order :id }

    accepts_nested_attributes_for :partial_types
    
    def self.export_config
      {
        except: [:id,:post_type_version_id],
        include: {
          partial_types: PartialType.export_config
        }
      }
    end

    def self.convert_nested_assoc(json_hash)
      json_hash[attrs_name].map!{|p_attrs|
        new_attrs = Pulitzer::PartialType.convert_hash_to_nested p_attrs
      }
      json_hash      
    end

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
