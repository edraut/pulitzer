module Pulitzer
  class Post < ActiveRecord::Base
    include ForeignOffice::Broadcaster if defined? ForeignOffice
    extend ::FriendlyId
    has_many :versions, dependent: :destroy
    has_one :active_version, -> { active }, class_name: "Pulitzer::Version"

    belongs_to :post_type
    delegate :post_type_content_element_types, :free_form_section_types, :has_free_form_sections?, :has_templated_content_elements?, to: :post_type
    delegate :post_tags, :content_elements, :content_element, :section, :has_label_type, :has_label, :post_tags_for, to: :active_version, allow_nil: true

    friendly_id :title, use: [:slugged, :finders]
    after_create :create_preview_version

    attr_accessor :new_preview_version

    validates :title, presence: true

    TAG_MODELS = ["Pulitzer::Tag"] + Pulitzer.tagging_models

    def active_version!
      versions.find_by!(status: Pulitzer::Version.statuses[:active])
    end

    def tags
      post_tags.map(&:label)
    end

    def should_generate_new_friendly_id?
      new_record? || title_changed?
    end

    def get_preview_version!
      this_version = versions.preview.last
      if this_version.present?
        return this_version
      elsif versions.processing.any?
        raise Pulitzer::VersionProcessingError.new("That version is still processing, it will be done soon." )
      else
        raise Pulitzer::VersionMissingError.new("We couldn't find a preview for that post, check with your system administrator to see how this happened.")
      end
    end

    def get_active_version!
      if active_version.present?
        return active_version
      else
        raise Pulitzer::VersionMissingError.new("We couldn't find that page. It looks like we no longer offer that.")
      end
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
