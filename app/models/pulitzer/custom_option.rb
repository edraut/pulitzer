module Pulitzer
  class CustomOption < ActiveRecord::Base
    belongs_to :custom_option_list
    has_many :content_elements
  end
end
