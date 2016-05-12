module Pulitzer
  class Tag < ActiveRecord::Base
    has_many :post_tags, as: :label, dependent: :destroy
    has_many :versions, through: :post_tags
    has_many :childs, class_name: 'Pulitzer::Tag', foreign_key: :parent_id
    belongs_to :parent, class_name: 'Pulitzer::Tag'
  end
end
