require 'rails'
require 'thin_man'
require 'hooch'
require 'carrierwave'
require 'friendly_id'
require 'select2-rails'
require 'pulitzer/engine'

module Pulitzer
  mattr_accessor  :base_controller, :metadata_closure, :authentication_closure,
  :tagging_models, :layout, :text_editor_toolbars

  def self.config(options)
    base_controller_name = options[:base_controller_name]
    @@base_controller         = base_controller_name.constantize
    @@metadata_closure        = options[:metadata_authorization]
    @@authentication_closure  = options[:authentication]
    @@tagging_models          = options[:tagging_models] || []
    @@layout                  = options[:layout] || 'application'
    default_text_editor       = [{ name: 'None', template: 'pulitzer/text_editors/none'}]
    user_text_editors         = options[:text_editor_toolbars].flatten || nil
    @@text_editor_toolbars    = default_text_editor.push(*user_text_editors).compact
  end

  def self.skip_metadata_auth?
    self.metadata_closure.blank?
  end

  def self.skip_authentication?
    self.authentication_closure.blank?
  end
end
