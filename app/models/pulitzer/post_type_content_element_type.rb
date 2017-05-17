module Pulitzer
  class PostTypeContentElementType < ActiveRecord::Base
    include Pulitzer::PostTypeElement
    
    belongs_to :post_type_version
    belongs_to :content_element_type
    has_one :content_element
    before_save :handle_sort_order

    delegate :type, :image_type?, to: :content_element_type

    default_scope { order(id: :asc) }

    validates :label, presence: true

  end
end
