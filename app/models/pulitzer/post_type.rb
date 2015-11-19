class Pulitzer::PostType < ActiveRecord::Base
  enum kind: [ :template, :free_form, :hybrid ]
  has_many :posts, dependent: :destroy
  has_many :post_type_content_element_types, dependent: :destroy
  has_many :content_element_types, through: :post_type_content_element_types

  validates :name, presence: true

  def self.named(label)
    self.find_by(name: label)
  end

  def singular?
    !plural
  end

  def singleton_post
    posts.first
  end

  def singleton_post?
    !!singleton_post
  end

  def allow_template?
    template? || hybrid?
  end

  def allow_free_form?
    free_form? || hybrid?
  end
end
