module Pulitzer
  class Tag < ActiveRecord::Base
    has_many :post_tags, as: :label, dependent: :destroy
    has_many :versions, through: :post_tags
    has_many :children, class_name: 'Pulitzer::Tag', foreign_key: :parent_id
    belongs_to :parent, class_name: 'Pulitzer::Tag'

    validates :name, presence: true, uniqueness: true

    scope :hierarchical, -> { where hierarchical: true  }
    scope :flat, -> { where hierarchical: false }
    scope :root, -> { hierarchical.where(parent_id: nil) } 
  end
end
