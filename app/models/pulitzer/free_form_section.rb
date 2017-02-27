module Pulitzer
  class FreeFormSection < ActiveRecord::Base
    belongs_to :version
    belongs_to :free_form_section_type
    has_many :partials, -> { order :sort_order}

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
