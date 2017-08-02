class Pulitzer::PostType < Pulitzer::ApplicationRecord
  enum kind: [ :template, :partial ]
  has_many :post_type_versions, dependent: :destroy, index_errors: true
  has_one :published_type_version, -> { where(status: 'published') }, class_name: 'PostTypeVersion'
  has_many :preview_type_versions, -> { where(status: 'prevew') }, class_name: 'PostTypeVersion'

  accepts_nested_attributes_for :post_type_versions
  
  scope :templates, -> { where(kind: Pulitzer::PostType.kinds[:template])}
  scope :partials, -> { where(kind: Pulitzer::PostType.kinds[:partial])}
  validates :name, :kind, presence: true
  validates :plural, :inclusion => { :in => [true, false] }

  attr_accessor :import_json
  
  def self.named(label)
    self.find_by(name: label)
  end

  def published_type_version_id
    published_type_version&.id
  end

  def most_recent_published_post_type_version
    post_type_versions&.published&.order(version_number: :desc)&.first
  end

  def most_recent_version_number
    most_recent_published_post_type_version&.version_number
  end
end
