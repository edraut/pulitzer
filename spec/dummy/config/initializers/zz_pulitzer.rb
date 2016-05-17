Pulitzer.config({
  base_controller_name: '::ApplicationController',
  authentication: Proc.new { true },
  metadata_authorization: Proc.new { true },
  tagging_models: [ 'SearchLocation' ],
  text_editor_toolbars: [
    { name: 'Simple editor', template: '/toolbars/simple_editor' }
  ]
})
