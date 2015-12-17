module Pulitzer
  class PostTag < ActiveRecord::Base
    belongs_to :version
    belongs_to :label, polymorphic: true
    validates :version_id, :label_id, :label_type, presence: true
  end
end
