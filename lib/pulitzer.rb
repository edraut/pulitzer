require 'pulitzer/engine'
require 'thin_man'
require 'hooch'
require 'carrierwave'

module Pulitzer
  mattr_accessor  :base_controller, :metadata_closure, :authentication_closure,
  :layout

  def self.config(options)
    base_controller_name = options[:base_controller_name]
    @@base_controller = base_controller_name.constantize
    @@metadata_closure = options[:metadata_authorization]
    @@authentication_closure = options[:authentication]
    @@layout = options[:layout] || 'application'
  end

  def self.skip_metadata_auth?
    self.metadata_closure.blank?
  end

  def self.skip_authentication?
    self.authentication_closure.blank?
  end
end
