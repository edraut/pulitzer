module Pulitzer
  class PartialTag < Pulitzer::ApplicationRecord
    belongs_to :partial
    belongs_to :label, polymorphic: true
    validates :partial, :label, presence: true

    def clone_me
      my_clone = self.dup
      my_clone.partial_id = nil
      my_clone
    end

  end
end
