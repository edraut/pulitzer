module Pulitzer
  class Version < ActiveRecord::Base
    enum status: [ :preview, :active, :archived, :abandoned ]
    has_many :content_elements, dependent: :destroy
    has_many :post_tags, dependent: :destroy
    belongs_to :post

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
  end
end
