module Pulitzer
  class Version < ActiveRecord::Base
    enum status: [ :archived, :active ]
    has_many :content_elements, dependent: :destroy
    has_many :post_tags, dependent: :destroy
    belongs_to :post
  end
end
