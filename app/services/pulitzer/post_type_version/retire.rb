class Pulitzer::PostTypeVersion::Retire
  include StateMachine::Transition

  self.action_name = :retire
  self.target_state = 'retired'
  self.valid_from_states = [:published]

  def initialize(post_type_version)
    @post_type_version = post_type_version
    self.object = @post_type_version
    self.errors = ActiveModel::Errors.new(self)
  end

  def retire
    self.validate_transition!
    update_status
    return true
  end

end
