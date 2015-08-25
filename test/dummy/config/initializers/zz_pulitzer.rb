Pulitzer.config({
  base_controller_name: '::ApplicationController',
  authentication: Proc.new { true },
  metadata_authorization: Proc.new { can? :manage, :pulitzer_metadata }
})
