module Pulitzer
  class Partial < ActiveRecord::Base
    belongs_to :free_form_section
    belongs_to :post_type_version
    belongs_to :background_style
    belongs_to :justification_style
    belongs_to :sequence_flow_style
    belongs_to :arrangement_style
    
    has_many :content_elements, dependent: :destroy

    delegate :name, :post_type_content_element_types, :has_display?, to: :post_type_version
    delegate :template_path, to: :layout, allow_nil: true

    before_save :handle_sort_order

    def content_element(label)
      self.content_elements.find_by(label: label)
    end

    def background_css_class
      background_style&.css_class_name
    end

    def justification_css_class
      justification_style&.css_class_name
    end

    def sequence_flow_css_class
      sequence_flow_style&.css_class_name
    end

    def handle_sort_order
      if new_record? && sort_order.nil?
        self.sort_order = free_form_section.partials.maximum(:sort_order).to_i + 1
      end
    end

    def available_backgrounds
      post_type.background_styles
    end

    def available_justifications
      post_type.justification_styles
    end

    def available_sequence_flows
      post_type.sequence_flow_styles
    end

    def available_arrangements
      post_type.arrangement_styles
    end

    def folder_path
      name.downcase.gsub(/ /,'_').gsub(/\W/,'')      
    end

    def template_path
      if arrangement_style.present?
        arrangement_style.view_file_name
      else
        'default'
      end
    end

    def full_view_path
      Pulitzer.partial_folder + '/' + folder_path + '/' + template_path
    end

    def clone_me
      clone_attrs = self.attributes.dup
      clone_attrs.delete 'id'
      clone_attrs.delete 'free_form_section_id'

      my_clone = Pulitzer::Partial.create!(clone_attrs)
      content_elements.each do |ce|
        cloned_content_element = ce.clone_me
        my_clone.content_elements << cloned_content_element
      end
      my_clone
    end

  end
end