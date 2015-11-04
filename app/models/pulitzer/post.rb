module Pulitzer
  class Post < ActiveRecord::Base
    extend ::FriendlyId
    has_many :versions
    belongs_to :post_type
    delegate :post_type_content_element_types, to: :post_type
    delegate :content_elements, :post_tags, to: :active_version
    friendly_id :title, use: [:slugged, :finders]
    after_create :create_version

    TAG_MODELS = ["Pulitzer::Tag"] + Pulitzer.tagging_models

    def content_element(label)
      self.content_elements.find_by(label: label)
    end

    def should_generate_new_friendly_id?
      new_record? || title_changed?
    end

    def active_version
    	versions.find_by(status: Pulitzer::Version.statuses[:active])
    end

    def activate(version)
    	self.active_version.archived!
    	version.active!
    end

  private
    def create_version
      self.versions.create status: :active
    end

  end
end
