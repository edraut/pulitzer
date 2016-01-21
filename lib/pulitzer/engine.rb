require 'pulitzer/content_element_helper'
module Pulitzer
  class Engine < ::Rails::Engine
    isolate_namespace Pulitzer

    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
    end

    initializer 'pulitzer.action_controller' do |app|
      ActionView::Base.send :include, ContentElementHelper
    end

  end
end
