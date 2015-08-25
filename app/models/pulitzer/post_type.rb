class Pulitzer::PostType < ActiveRecord::Base
  has_many :posts
  has_many :post_type_content_element_types, dependent: :destroy
  has_many :content_element_types, through: :post_type_content_element_types

  validates :name, presence: true

  def singular?
    !plural
  end

  def singleton_post
    posts.first
  end

  def singleton_post?
    !!singleton_post
  end

  def self.named(label)
    self.find_by(name: label)
  end
end
