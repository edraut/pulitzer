class Pulitzer::PostTypeVersion::Preview
  include StateMachine::Transition

  self.action_name = :preview
  self.target_state = 'preview'
  self.valid_from_states = [:incomplete]

  def initialize(post_type_version)
    @post_type_version = post_type_version
    self.object = @post_type_version
    self.errors = ActiveModel::Errors.new(self)
  end

  def preview
    self.validate_transition!
    validate_elements or return false
    update_status
    return true
  end

  def validate_elements
    if @post_type_version.post_type_content_element_types.empty? &&
        @post_type_version.free_form_section_types.empty?
      @post_type_version.errors.add(:base, 'You must set up all the content elements and free form sections before previewing the post type')
      return false
    end
    return true
  end

end
