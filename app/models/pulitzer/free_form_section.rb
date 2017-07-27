module Pulitzer
  class FreeFormSection < Pulitzer::ApplicationRecord
    belongs_to :version
    belongs_to :free_form_section_type
    has_many :partials, -> { order :sort_order}

    accepts_nested_attributes_for :partials
    
    delegate :sort_order, to: :free_form_section_type, allow_nil: true
    
    def self.export_config
      {
        except: [:id, :version_id, :free_form_section_type_id],
        include: {
          partials: Pulitzer::Partial.export_config
        }
      }
    end

    def self.convert_nested_assoc(json_hash)
      json_hash[attrs_name].map!{|ffs_attrs|
        new_attrs = Pulitzer::Partial.convert_hash_to_nested ffs_attrs
      }
      json_hash      
    end

    def partial(name)
      self.partials.to_a.detect{|ffs| ffs.name == name}
    end

    def clone_me
      clone_attrs = self.attributes.dup
      clone_attrs.delete 'id'
      clone_attrs.delete 'version_id'

      my_clone = Pulitzer::FreeFormSection.create!(clone_attrs)
      partials.each do |partial|
        cloned_partial = partial.clone_me
        my_clone.partials << cloned_partial
      end
      my_clone
    end

  end
end
