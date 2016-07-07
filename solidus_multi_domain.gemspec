# encoding: UTF-8

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = "solidus_multi_domain"
  s.version     = "1.4.3"
  s.summary     = "Adds multiple site support to Solidus"
  s.description = "Multiple Solidus stores on different domains - single unified backed for processing orders."
  s.required_ruby_version = ">= 2.1"

  s.author       = "Solidus Team"
  s.email        = "contact@solidus.io"
  s.homepage     = "https://solidus.io"
  s.license      = %q{BSD-3}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = "lib"
  s.requirements << "none"

  s.add_dependency "solidus", '~> 1.1'
  s.add_dependency "deface"

  s.add_development_dependency "rspec-rails",  "~> 3.2"
  s.add_development_dependency "simplecov"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "sass-rails"
  s.add_development_dependency "coffee-rails"
  s.add_development_dependency "factory_girl", "~> 4.5"
  s.add_development_dependency "capybara"
  s.add_development_dependency "poltergeist"
  s.add_development_dependency "capybara-screenshot"
  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "ffaker"
end
