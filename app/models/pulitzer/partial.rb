module Pulitzer
  class Partial < ActiveRecord::Base
    belongs_to :free_form_section
    belongs_to :post_type
    belongs_to :layout
    
    has_many :content_elements, dependent: :destroy

    delegate :name, :post_type_content_element_types, :has_display?, to: :post_type
    delegate :template_path, to: :layout, allow_nil: true

    before_save :handle_sort_order

    def content_element(label)
      self.content_elements.find_by(label: label)
    end

    def handle_sort_order
      if new_record? && sort_order.nil?
        self.sort_order = free_form_section.partials.maximum(:sort_order).to_i + 1
      end
    end

    def available_layouts
      post_type.layouts
    end

    def folder_path
      name.downcase.gsub(/ /,'_').gsub(/\W/,'')      
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