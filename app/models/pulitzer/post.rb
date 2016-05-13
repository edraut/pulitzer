module Pulitzer
  class Post < ActiveRecord::Base
    include ForeignOffice::Broadcaster if defined? ForeignOffice
    extend ::FriendlyId
    has_many :versions
    belongs_to :post_type
    delegate :post_type_content_element_types, :free_form_section_types, :has_free_form_sections?, :has_templated_content_elements?, to: :post_type
    delegate :content_elements, :post_tags, :has_label_type, :has_label, :post_tags_for, to: :active_version, allow_nil: true
    friendly_id :title, use: [:slugged, :finders]
    after_create :create_preview_version

    attr_accessor :new_preview_version

    validates :title, presence: true

    TAG_MODELS = ["Pulitzer::Tag"] + Pulitzer.tagging_models

    def content_element(label)
      if content_elements
        self.content_elements.find_by(label: label)
      end
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

    def processing_version
      versions.processing.last
    end

    def processing_failed_version
      versions.processing_failed.last
    end

    def next_version
      preview_version || processing_version || processing_failed_version
    end

    def create_preview_version
      versions.create(status: :preview)
    end

    def create_processing_version
      versions.create(status: :processing)
    end

    def serialize
      self.attributes.merge \
        new_preview_version: self.new_preview_version
    end
  end
end
