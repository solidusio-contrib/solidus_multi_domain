# encoding: UTF-8

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = "solidus_multi_domain"
  s.version     = "1.0.0"
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

  version = "~> 2.4.0"
  s.add_dependency "spree_core", version
  s.add_dependency "spree_backend", version
  s.add_dependency "spree_frontend", version
  s.add_dependency "spree_api", version

  s.add_development_dependency "rspec-rails",  "~> 2.7"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "sass-rails", "~> 4.0.2"
  s.add_development_dependency "coffee-rails", "~> 4.0.0"
  s.add_development_dependency "factory_girl", "~> 4.5.0"
  s.add_development_dependency "capybara", "~> 2.4"
end
