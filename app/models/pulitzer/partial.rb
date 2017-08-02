module Pulitzer
  class Partial < Pulitzer::ApplicationRecord
    include ForeignOffice::Broadcaster if defined? ForeignOffice

    belongs_to :free_form_section
    belongs_to :post_type_version
    belongs_to :background_style
    belongs_to :justification_style
    belongs_to :sequence_flow_style
    belongs_to :arrangement_style
    has_one :post_type, through: :post_type_version

    has_many :content_elements, dependent: :destroy

    accepts_nested_attributes_for :content_elements
    
    attr_accessor :reload_show, :remove_show

    delegate :name, :post_type_content_element_types, :has_display?, :post_type_id, :version_number, to: :post_type_version
    delegate :most_recent_version_number, to: :post_type
    delegate :template_path, to: :layout, allow_nil: true

    before_save :handle_sort_order

    def self.export_config
      {
        except: [:id, :free_form_section_id],
        include: {
          content_elements: Pulitzer::ContentElement.export_config
        }
      }
    end

    def self.convert_nested_assoc(json_hash)
      json_hash[attrs_name].map!{|p_attrs|
        new_attrs = Pulitzer::ContentElement.convert_hash_to_nested p_attrs
      }
      json_hash      
    end

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
      post_type_version.background_styles
    end

    def available_justifications
      post_type_version.justification_styles
    end

    def available_sequence_flows
      post_type_version.sequence_flow_styles
    end

    def available_arrangements
      post_type_version.arrangement_styles
    end

    def folder_path
      name.downcase.gsub(/ /,'_').gsub(/\W/,'')
    end

    def version_folder
      "v_#{version_number}"
    end

    def template_path
      if arrangement_style.present?
        arrangement_style.view_file_name
      else
        'default'
      end
    end

    def full_view_path
      File.join Pulitzer.partial_folder, folder_path, version_folder, template_path
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

    def upgradable?
      version_number < (post_type_version&.post_type&.post_type_versions&.published&.maximum(:version_number) || 0)
    end

    def serialize
      self.attributes.merge \
        reload_show: self.reload_show
    end
  end
end
