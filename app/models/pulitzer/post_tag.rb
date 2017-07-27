module Pulitzer
  class PostTag < Pulitzer::ApplicationRecord
    belongs_to :version
    belongs_to :label, polymorphic: true
    validates :version, :label, presence: true

    def self.export_config
      { except: [:id, :version_id, :created_at, :updated_at] }

    end

    def clone_me
      my_clone = self.dup
      my_clone.version_id = nil
      my_clone
    end

  end
end
