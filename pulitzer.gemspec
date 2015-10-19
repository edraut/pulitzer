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

  s.add_dependency 'rails', '~> 4.2'
  s.add_dependency 'hooch', '~> 0.3.0'
  s.add_dependency 'sass-rails', '~> 4.0'
  s.add_dependency 'thin_man', '~> 0.11.6'
  s.add_dependency 'simple_form', '~> 3.2', '>= 3.2.0'
  s.add_dependency 'kaminari', '~> 0.16.0'
  s.add_dependency 'carrierwave', '~> 0.10.0'
  s.add_dependency 'carrierwave-aws', '~> 0.4.1'
  s.add_dependency 'mini_magick', '~> 4.3', '>= 4.3.0'
  s.add_dependency 'friendly_id', '~> 5.1', '>= 5.1.0'
  s.add_dependency 'select2-rails', '~> 4.0', '>= 4.0.0'

  s.add_development_dependency 'sqlite3', '~> 1.3'
  s.add_development_dependency 'minitest', '~> 5.1'
  s.add_development_dependency 'byebug', '~> 6.0'
  s.add_development_dependency 'cancancan', '~> 1.10'
  s.add_development_dependency 'rspec-rails', '~> 3.2', '>= 3.2.0'
end
