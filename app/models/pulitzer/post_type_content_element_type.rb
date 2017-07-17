module Pulitzer
  class PostTypeContentElementType < ActiveRecord::Base
    include Pulitzer::PostTypeElement

    belongs_to :post_type_version
    belongs_to :content_element_type
    has_many :styles

    before_save :handle_sort_order

    delegate :type, :image_type?, :has_styles?, to: :content_element_type

    default_scope { order(sort_order: :asc) }

    validates :label, presence: true

    Any_clickable = OpenStruct.new
    Any_clickable.gid = 'any'
    Any_clickable.name = 'Any'
    Any_clickable.freeze

    URL_clickable = OpenStruct.new
    URL_clickable.gid = 'url'
    URL_clickable.name = 'URL'
    URL_clickable.freeze

    def self.clickable_kinds
      [Any_clickable] + Pulitzer::CustomOptionList.all.to_a + [URL_clickable]
    end

    def clickable_kind_display
      GlobalID::Locator.locate(clickable_kind)&.name || clickable_kind.humanize
    end

    def any_clickable_kind?
      'any' == clickable_kind
    end

    def url_clickable_kind?
      'url' == clickable_kind
    end

    def clickable_kinds
      Pulitzer::CustomOptionList.all.to_a + [URL_clickable]
    end

    def custom_clickable_kinds
      Pulitzer::CustomOptionList.all.to_a
    end

    def custom_option_list
      GlobalID::Locator.locate(clickable_kind)
    end

    def custom_options
      custom_option_list&.custom_options
    end

    def type_specific_display
      case type
      when :image
        "#{height}x#{width}"
      when :text
        text_editor_display
      when :clickable
        clickable_kind_display
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

    def first_style
      styles.first
    end

    def clone_me
      clone_attrs = self.attributes.dup
      clone_attrs.delete 'id'
      clone_attrs.delete 'post_type_version_id'
      Pulitzer::PostTypeContentElementType.new(clone_attrs)
    end

  end
end
