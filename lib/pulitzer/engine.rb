require 'pulitzer/content_element_helper'
module Pulitzer
  class Engine < ::Rails::Engine
    isolate_namespace Pulitzer

    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
    end

    config.to_prepare do
      ApplicationController.helper(MainHelper)
    end

    initializer 'pulitzer.action_controller' do |app|
      ActionView::Base.send :include, ContentElementHelper
      ActionView::Base.send :include, Pulitzer::PostsHelper
    end

  end
end
