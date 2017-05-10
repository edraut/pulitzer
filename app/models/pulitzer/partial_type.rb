module Pulitzer
  class PartialType < ActiveRecord::Base
    belongs_to :free_form_section_type
    belongs_to :post_type
    belongs_to :layout

    delegate :template_path, to: :layout, allow_nil: true


    def folder_path
      label.downcase.gsub(/ /,'_').gsub(/\W/,'')
    end
  end
end
