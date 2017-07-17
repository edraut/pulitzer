class Pulitzer::PostTypeVersion < ActiveRecord::Base
  include StateMachine::Model
  include ForeignOffice::Broadcaster if defined? ForeignOffice
  enum processing_status: [ :unprocessed, :processing, :processing_failed, :processed ]

  belongs_to :post_type
  has_many :posts, dependent: :destroy
  has_many :partials, dependent: :destroy
  has_many :post_type_content_element_types, dependent: :destroy
  has_many :content_element_types, through: :post_type_content_element_types
  has_many :free_form_section_types, dependent: :destroy
  has_many :background_styles, dependent: :destroy
  has_many :justification_styles, dependent: :destroy
  has_many :sequence_flow_styles, dependent: :destroy
  has_many :arrangement_styles, dependent: :destroy
  attr_accessor :processed_element_count, :finished_processing

  delegate :name, :kind, :partial?, :template?, :plural, :plural?, to: :post_type

  scope :published, -> { where(status: 'published') }

  register_transitions({
    previewing_service: Preview,
    publishing_service: Publish,
    retiring_service: Retire })

  def full_name
    "\"#{name}\" v#{version_number}"
  end

  def singular?
    !plural
  end

  def singleton_post
    posts.first
  end

  def singleton_post?
    !plural
  end

  def arity_display
    plural? ? 'Many Posts' : 'Single Post'
  end

  def has_display?
    background_styles.any? || justification_styles.any? || sequence_flow_styles.any? || arrangement_styles.any?
  end

  def has_templated_content_elements?
    content_element_types.any?
  end

  def has_free_form_sections?
    free_form_section_types.any?
  end

  def all_element_types
    (post_type_content_element_types.to_a + free_form_section_types.to_a)
  end

  def highest_element_sort
    last_element = all_element_types.max_by{ |e| e.sort_order || 0}
    last_element&.sort_order || 0
  end

  def locked?
    published? || retired?
  end

  def status_display
    {'incomplete' => 'Not Ready',
      'preview' => 'Previewing',
      'published' => 'Published',
      'retired' => 'Retired'}[status]
  end

  def state_change
    {'incomplete' => :preview,
      'preview' => :publish,
      'published' => :retire,
      'retired' => :publish}[status]
  end

  def state_change_display
    state_change.to_s.humanize
  end

  def serialize
    self.attributes.merge \
      processed_element_count: self.processed_element_count,
      finished_processing: self.finished_processing
  end

  def published_posts_count
    post_type.published_type_version.posts.count
  end
end
