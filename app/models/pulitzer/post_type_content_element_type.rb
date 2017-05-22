module Pulitzer
  class PostTypeContentElementType < ActiveRecord::Base
    include Pulitzer::PostTypeElement
    
    belongs_to :post_type
    belongs_to :content_element_type
    has_one :content_element
    before_save :handle_sort_order

    delegate :type, :image_type?, to: :content_element_type

    default_scope { order(sort_order: :asc) }

    validates :label, presence: true

    def type_specific_display
      case type
      when :image
        "#{height}x#{width}"
      when :text
        text_editor_display
      else
        ''
      end
    end

    def text_editor_display
      case text_editor
      when 'None'
        'no editor'
      else
        text_editor
      end
    end
  end
end
