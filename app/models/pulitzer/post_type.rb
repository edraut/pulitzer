class Pulitzer::PostType < ActiveRecord::Base
  enum kind: [ :template, :partial ]
  has_many :post_type_versions, dependent: :destroy
  has_one :published_type_version, -> { where(status: 'published') }, class_name: 'PostTypeVersion'
  has_many :preview_type_versions, -> { where(status: 'prevew') }, class_name: 'PostTypeVersion'

  scope :templates, -> { where(kind: Pulitzer::PostType.kinds[:template])}
  scope :partials, -> { where(kind: Pulitzer::PostType.kinds[:partial])}
  validates :name, :kind, presence: true
  validates :plural, :inclusion => { :in => [true, false] }

  def self.named(label)
    self.find_by(name: label)
  end

  def published_type_version_id
    published_type_version&.id
  end
end
