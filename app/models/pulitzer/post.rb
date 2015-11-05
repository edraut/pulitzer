module Pulitzer
  class Post < ActiveRecord::Base
    extend ::FriendlyId
    has_many :versions
    belongs_to :post_type
    delegate :post_type_content_element_types, to: :post_type
    delegate :content_elements, :post_tags, to: :preview_version
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

    def preview_version
    	versions.find_by(status: Pulitzer::Version.statuses[:preview])
    end

    def create_version
      self.active_version.update(status: :archived) unless self.active_version.nil?
      self.versions.create status: :preview
    end

  end
end
