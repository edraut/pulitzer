module Pulitzer
  class BackgroundStyle < ActiveRecord::Base
    belongs_to :post_type_version
    has_many :partials
    validates :display_name, presence: true
    validates :css_class_name, presence: true
  end
end
