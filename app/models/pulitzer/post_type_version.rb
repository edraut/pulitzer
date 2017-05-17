class Pulitzer::PostTypeVersion < ActiveRecord::Base
  include StateMachine::Model

  belongs_to :post_type
  has_many :posts, dependent: :destroy
  has_many :post_type_content_element_types, dependent: :destroy
  has_many :content_element_types, through: :post_type_content_element_types
  has_many :free_form_section_types, dependent: :destroy
  has_many :layouts, dependent: :destroy

  delegate :name, :kind, :partial?, :template?, to: :post_type

  register_transitions({
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
end