$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "pulitzer/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "pulitzer"
  s.version     = Pulitzer::VERSION
  s.authors     = ["Eric Draut", "Jean Guarin"]
  s.email       = ["edraut@gmail.com", "escribimepues@gmail.com"]
  s.homepage    = "https://github.com/edraut/pulitzer"
  s.summary     = "A content management engine for Ruby on Rails."
  s.description = "A content management system that works with your view templates. Keep the presses hot!"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency 'rails', '>=5', '< 6'
  s.add_dependency 'hooch', '>= 0.7.0', '< 1.0'
  s.add_dependency 'sass-rails', '>= 4.0', '< 6'
  s.add_dependency 'thin_man', '>= 0.12.2', '< 1.0'
  s.add_dependency 'foreign_office', ">= 0.9.1", '< 1.0'
  s.add_dependency 'simple_form', '~> 3.2', '>= 3.2.0'
  s.add_dependency 'kaminari', '>= 0.16.0', '< 1.0'
  s.add_dependency 'carrierwave', '< 1.0'
  s.add_dependency 'carrierwave-aws', '< 2.0'
  s.add_dependency 'mini_magick', '~> 4.3', '>= 4.3.0'
  s.add_dependency 'friendly_id', '~> 5.1', '>= 5.1.0'
  s.add_dependency 'select2-rails', '~> 4.0', '>= 4.0.0'
  s.add_dependency 'aws-sdk', '< 3.0'

  s.add_development_dependency 'sqlite3', '~> 1.3', '< 2.0'
  s.add_development_dependency 'minitest', '~> 5.1', '< 6.0'
  s.add_development_dependency 'byebug', '~> 8.0'
  s.add_development_dependency 'pry-rails', '~> 0.3', '< 1.0'
  s.add_development_dependency 'pry-nav', '~> 0.2.4', '< 1.0'
  s.add_development_dependency 'pry-remote', '0.1.8', '< 1.0'
  s.add_development_dependency 'cancancan', '~> 1.10'
  s.add_development_dependency 'rspec', '~> 3.6'
  s.add_development_dependency 'rspec-rails', '>= 3.6', '< 4.0'
  s.add_development_dependency 'fuubar', '>= 2', '< 3'
  s.add_development_dependency 'factory_girl_rails', '~> 4.5.0', '< 5.0'
  s.add_development_dependency 'shoulda-matchers', '~> 3.0.0', '< 4.0'
  s.add_development_dependency 'database_cleaner', '~> 1.5.1', '< 2.0'
  s.add_development_dependency 'rails-controller-testing'
end
