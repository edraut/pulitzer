module Pulitzer
  class PostTag < ActiveRecord::Base
    belongs_to :version
    belongs_to :label, polymorphic: true
  end
end
