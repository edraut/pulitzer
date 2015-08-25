$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "pulitzer/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "pulitzer"
  s.version     = Pulitzer::VERSION
  s.authors     = ["Eric Draut"]
  s.email       = ["edraut@gmail.com"]
  s.homepage    = "https://github.com/edraut/pulitzer"
  s.summary     = "A content management engine for Ruby on Rails."
  s.description = "A content management system that works with your view templates. Keep the presses hot!"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2"
  s.add_dependency "hooch"
  s.add_dependency "sass-rails"
  s.add_dependency "thin_man"
  s.add_dependency "simple_form"
  s.add_dependency "kaminari"
  s.add_dependency "carrierwave"
  s.add_dependency "carrierwave-aws"
  s.add_dependency "mini_magick"
  s.add_dependency "friendly_id"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "minitest"
  s.add_development_dependency "byebug"
  s.add_development_dependency "cancancan"
  s.add_development_dependency "rspec-rails"
end
