module Pulitzer
  class Tag < Pulitzer::ApplicationRecord
    has_many :post_tags, as: :label, dependent: :destroy, inverse_of: :label
    has_many :versions, through: :post_tags
    has_many :posts, through: :versions

    has_many :active_versions, -> { active }, through: :post_tags, source: :version
    has_many :active_posts, through: :active_versions, source: :post

    has_many :children, class_name: 'Pulitzer::Tag', dependent: :destroy, foreign_key: :parent_id
    belongs_to :parent, class_name: 'Pulitzer::Tag', touch: true

    validates :name, presence: true, uniqueness: true

    scope :hierarchical, -> { where hierarchical: true  }
    scope :flat,  -> { where hierarchical: false }
    scope :root,  -> { hierarchical.where(parent_id: nil) }

    def self.named(name = "")
      find_by name: name
    end

    def root?
      hierarchical? && parent_id.nil?
    end
  end
end
