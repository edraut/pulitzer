module Pulitzer
  class PostTag < ActiveRecord::Base
    belongs_to :post
    belongs_to :label, polymorphic: true
  end
end
