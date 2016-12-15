module Pulitzer
  class Version < ActiveRecord::Base
    include ForeignOffice::Broadcaster if defined? ForeignOffice
    enum status: [ :preview, :active, :archived, :abandoned, :processing, :processing_failed ]
    has_many :content_elements, dependent: :destroy
    has_many :free_form_sections, dependent: :destroy
    has_many :post_tags, dependent: :destroy
    has_many :tags, through: :post_tags, source: :label, source_type: "Pulitzer::Tag"
    belongs_to :post
    scope :tagged_with_type, ->(label_type){includes(:post_tags).where(pulitzer_post_tags: {label_type: label_type}).references(:pulitzer_post_tags)}
    scope :tagged_with_label, ->(label){includes(:post_tags).where(pulitzer_post_tags:{label_type: label.class.name, label_id: label.id}).references(:pulitzer_post_tags)}
    attr_accessor :processed_element_count

    delegate :has_free_form_sections?, :has_templated_content_elements?, :title, :slug, :active_version, to: :post

    validates :post_id, :status, presence: true

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

    def empty_required_content_elements?
      content_elements.required.select{|ce| ce.empty_body?}.any? || free_form_sections.includes(partials: :content_elements).map(&:partials).flatten.map(&:content_elements).flatten.select{|ce| ce.empty_body? && ce.required?}.any?
    end
  end
end
