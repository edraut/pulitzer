module Pulitzer
  class Post < ActiveRecord::Base
    extend ::FriendlyId
    has_many :versions
    belongs_to :post_type
    delegate :post_type_content_element_types, to: :post_type
    delegate :content_elements, :post_tags, to: :active_version, allow_nil: true
    friendly_id :title, use: [:slugged, :finders]
    after_create :create_preview_version

    validates :title, presence: true

    TAG_MODELS = ["Pulitzer::Tag"] + Pulitzer.tagging_models

    def content_element(label)
      self.content_elements.find_by(label: label)
    end

    def should_generate_new_friendly_id?
      new_record? || title_changed?
    end

    def active_version
    	versions.active.last
    end

    def preview_version
    	versions.preview.last
    end

    def create_preview_version
      versions.create(status: :preview)
    end

  end
end
