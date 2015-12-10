module Pulitzer
  class Tag < ActiveRecord::Base
    has_many :post_tags, as: :label, dependent: :destroy
    has_many :versions, through: :post_tags

    validates :name, presence: true, uniqueness: true
  end
end
