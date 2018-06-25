module Pulitzer
  class Version < Pulitzer::ApplicationRecord
    include ForeignOffice::Broadcaster if defined? ForeignOffice
    enum status: [ :preview, :active, :archived, :abandoned, :processing, :processing_failed ]
    has_many :content_elements, -> {includes(:post_type_content_element_type)}, dependent: :destroy, index_errors: true, inverse_of: :version
    has_many :free_form_sections, -> {includes(partials: {content_elements: :post_type_content_element_type})}, dependent: :destroy, index_errors: true, inverse_of: :version
    has_many :post_tags, dependent: :destroy, index_errors: true, inverse_of: :version
    has_many :tags, through: :post_tags, source: :label, source_type: "Pulitzer::Tag"
    belongs_to :post

    accepts_nested_attributes_for :content_elements, :free_form_sections, :post_tags
    
    scope :tagged_with_type, ->(label_type){includes(:post_tags).where(pulitzer_post_tags: {label_type: label_type}).references(:pulitzer_post_tags)}
    scope :tagged_with_label, ->(label){includes(:post_tags).where(pulitzer_post_tags:{label_type: label.class.name, label_id: label.id}).references(:pulitzer_post_tags)}
    attr_accessor :processed_element_count

    delegate :has_free_form_sections?, :has_templated_content_elements?, :title, :slug, :active_version, to: :post

    validates :post, :status, presence: true

    def self.export_config
      {
        except: [:id, :post_id, :created_at, :updated_at, :cloning_status],
        include: {
          content_elements: ContentElement.export_config,
          free_form_sections: FreeFormSection.export_config,
          post_tags: PostTag.export_config
        }
      }
    end

    def self.convert_nested_assoc(json_hash)
      json_hash[attrs_name].map!{|v_attrs|
        new_attrs = Pulitzer::ContentElement.convert_hash_to_nested v_attrs
        new_attrs = Pulitzer::FreeFormSection.convert_hash_to_nested new_attrs
        new_attrs = Pulitzer::PostTag.convert_hash_to_nested new_attrs
      }
      json_hash
    end

    def has_label_type(label_type)
      post_tags.to_a.select{|pt| pt.label_type == label_type}.any?
    end

    def has_label(label)
      post_tags.to_a.select{|pt| pt.label_type == label.class.name && pt.label_id == label.id}.any?
    end

    def post_tags_for(label_type)
      post_tags.to_a.select{|pt| pt.label_type == label_type}
    end

    def content_element(label)
      self.content_elements.to_a.detect{|ce| ce.label == label}
    end

    def section(name)
      self.free_form_sections.to_a.detect{|ffs| ffs.name == name}
    end

    def all_elements
      (content_elements.to_a + free_form_sections.to_a).sort_by{|e| e.sort_order || 0}
    end

    def template_content_elements
      content_elements.template
    end

    def total_processing_elements
      active_version.content_elements.count + active_version.post_tags.count + active_version.free_form_sections.count + 2
    end

    def serialize
      self.attributes.merge \
        processed_element_count: self.processed_element_count
    end

    def publishable?
      !missing_required_content_elements?
    end

    def missing_required_content_elements
      @missing_content_elements ||= content_elements.to_a.select{|ce| ce.empty_body? && ce.required?}
    end

    def missing_required_partial_elements
      @missing_partial_elements ||= free_form_sections.to_a.map(&:partials).flatten.map(&:content_elements).flatten.select{|ce| ce.empty_body? && ce.required?}
    end

    def missing_required_content_elements?
      missing_required_partial_elements.any? || missing_required_content_elements.any? || missing_required_partial_types.any?
    end

    def missing_required_partial_types
      missing_required_partial_types = []
      ffsts = post.post_type_version.free_form_section_types
      ffsts.each do |ffst|
        ffs = free_form_sections.find_by(name: ffst.name)
        existing_partial_post_types = ffs&.partials&.map(&:post_type_version_id)
        existing_partial_post_types ||= []
        missing_required_partial_types += ffst.partial_types.to_a.select{|pt| existing_partial_post_types.exclude? pt.post_type_version_id}
      end
      missing_required_partial_types
    end

    def missing_requirement_messages
      missing_required_content_elements.map{|ce| "#{ce.label} is required"} +
      missing_required_partial_elements.map{|ce| "#{ce.partial.free_form_section.name} -> #{ce.partial.label} -> #{ce.label} is required"} +
      missing_required_partial_types.map{|pt| "#{pt.free_form_section_type.name} -> #{pt.post_type_version.name} is required"}
    end
  end
end
