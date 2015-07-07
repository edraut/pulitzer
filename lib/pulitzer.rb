require "pulitzer/engine"
require 'thin_man'

module Pulitzer
  mattr_accessor  :base_controller, :metadata_closure

  def self.config(options)
    base_controller_name = options[:base_controller_name]
    @@base_controller = base_controller_name.constantize
    @@metadata_closure = options[:metadata_authorization]
  end
end
