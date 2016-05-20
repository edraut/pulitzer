module Pulitzer
  class PostTag < ActiveRecord::Base
    belongs_to :version, touch: true
    belongs_to :label, polymorphic: true, touch: true
    validates :version_id, :label_id, :label_type, presence: true

    def clone_me
      my_clone = self.dup
      my_clone.version_id = nil
      my_clone
    end

  end
end
