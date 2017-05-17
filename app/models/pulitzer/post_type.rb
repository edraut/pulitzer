class Pulitzer::PostType < ActiveRecord::Base
  enum kind: [ :template, :partial ]
  has_many :post_type_versions, dependent: :destroy
  has_one :published_type_version, -> { where(status: 'published') }, class_name: 'PostTypeVersion'
  has_many :posts, through: :published_type_version
  has_many :partials, through: :published_type_version
  has_many :post_type_content_element_types, through: :published_type_version
  has_many :content_element_types, through: :post_type_content_element_types
  has_many :free_form_section_types, through: :published_type_version
  has_many :layouts, through: :published_type_version

  scope :templates, -> { where(kind: Pulitzer::PostType.kinds[:template])}
  scope :partials, -> { where(kind: Pulitzer::PostType.kinds[:partial])}
  validates :name, :kind, presence: true
  validates :plural, :inclusion => { :in => [true, false] }

  def self.named(label)
    self.find_by(name: label)
  end

end
