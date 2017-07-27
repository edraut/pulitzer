module Pulitzer
  class CustomOptionList < Pulitzer::ApplicationRecord
    belongs_to :content_element_type
    has_many :custom_options

    def gid
      to_global_id.to_s
    end
  end
end
