require "pulitzer/engine"
require 'thin_man'

module Pulitzer
  mattr_accessor  :base_controller

  def self.config(options)
    base_controller_name = options[:base_controller_name]
    @@base_controller = base_controller_name.constantize
  end
end
