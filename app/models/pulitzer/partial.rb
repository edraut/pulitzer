module Pulitzer
  class Partial < ActiveRecord::Base
    belongs_to :version
    belongs_to :post_type
    has_many :content_elements, dependent: :destroy

    delegate :template_path, to: :post_type

  end
end