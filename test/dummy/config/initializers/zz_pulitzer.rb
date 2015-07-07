Pulitzer.config({
  base_controller_name: '::ApplicationController',
  metadata_authorization: Proc.new { can? :manage, :pulitzer_metadata }
})
