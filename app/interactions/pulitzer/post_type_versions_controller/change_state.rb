class Pulitzer::PostTypeVersionsController::ChangeState

  def initialize(ptv,state_change)
    @ptv, @state_change = ptv, state_change.to_sym
  end

  def call
    sanitize_state_change or return false
    @ptv.send @state_change
  end

  def sanitize_state_change
    return [:publish,:retire,:preview].include? @state_change
  end
end