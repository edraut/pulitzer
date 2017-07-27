module Pulitzer
  class CustomOption < Pulitzer::ApplicationRecord
    belongs_to :custom_option_list
    has_many :content_elements
  end
end
