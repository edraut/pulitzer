ENV["RAILS_ENV"] ||= 'test'
require 'spec_helper'
require File.expand_path("../dummy/config/environment", __FILE__)
require 'rspec/rails'
require 'shoulda-matchers'
require 'factory_girl_rails'

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!

  config.include(Shoulda::Matchers::ActiveModel, type: :model)
  config.include(Shoulda::Matchers::ActiveRecord, type: :model)

  config.before(:suite) do
    ActiveRecord::Base.connection.tables.each do |name|
      begin
        ActiveRecord::Base.connection.execute("TRUNCATE TABLE #{name};")
      rescue ActiveRecord::StatementInvalid
        ActiveRecord::Base.connection.execute("delete from #{name};")
      end
    end
    Rails.application.load_seed
  end
end
