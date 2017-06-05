module Pulitzer
  class ArrangementStyle < ActiveRecord::Base
    belongs_to :post_type_version
    has_many :partials
    validates :display_name, presence: true
    validates :view_file_name, presence: true
  end
end
