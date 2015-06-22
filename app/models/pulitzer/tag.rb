module Pulitzer
  class Tag < ActiveRecord::Base
    has_many :post_tags, as: :label, dependent: :destroy
    has_many :posts, through: :post_tags
  end
end
