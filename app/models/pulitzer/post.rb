module Pulitzer
  class Post < ActiveRecord::Base
    belongs_to :post_type
    has_many :content_elements, dependent: :destroy
    has_many :post_tags, dependent: :destroy
    has_many :tags, through: :post_tags
  end
end
