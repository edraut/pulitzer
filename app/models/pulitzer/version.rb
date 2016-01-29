module Pulitzer
  class Version < ActiveRecord::Base
    include ForeignOffice::Broadcaster if defined? ForeignOffice
    enum status: [ :preview, :active, :archived, :abandoned, :processing, :processing_failed ]
    has_many :content_elements, dependent: :destroy
    has_many :post_tags, dependent: :destroy
    belongs_to :post

    attr_accessor :processed_element_count

    delegate :allow_free_form?, :title, :slug, to: :post

    validates :post_id, :status, presence: true

    def content_element(label)
      self.content_elements.find_by(label: label)
    end

    def template_content_elements
      content_elements.template
    end

    def free_form_content_elements
      content_elements.free_form
    end

    def serialize
      self.attributes.merge \
        processed_element_count: self.processed_element_count
    end
  end
end
