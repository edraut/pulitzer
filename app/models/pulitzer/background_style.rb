module Pulitzer
  class BackgroundStyle < ActiveRecord::Base
    belongs_to :post_type
    has_many :partials
    validates :display_name, presence: true
    validates :css_class_name, presence: true
  end
end
