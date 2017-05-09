module Pulitzer
  class PartialType < ActiveRecord::Base
    belongs_to :free_form_section_type
  end
end
