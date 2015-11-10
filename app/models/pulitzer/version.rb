module Pulitzer
  class Version < ActiveRecord::Base
    enum status: [ :preview, :active, :archived, :abandoned ]
    has_many :content_elements, dependent: :destroy
    has_many :post_tags, dependent: :destroy
    belongs_to :post
  end
end
