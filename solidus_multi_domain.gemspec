# frozen_string_literal: true

require_relative 'lib/solidus_multi_domain/version'

Gem::Specification.new do |spec|
  spec.name = 'solidus_multi_domain'
  spec.version = SolidusMultiDomain::VERSION
  spec.authors = ['Solidus Team']
  spec.email = 'contact@solidus.io'

  spec.summary = 'Adds multiple site support to Solidus'
  spec.description = 'Multiple Solidus stores on different domains - single unified backed for processing orders.'
  spec.homepage = 'https://github.com/solidusio-contrib/solidus_multi_domain#readme'
  spec.license = 'BSD-3-Clause'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/solidusio-contrib/solidus_multi_domain'
  spec.metadata['changelog_uri'] = 'https://github.com/solidusio-contrib/solidus_multi_domain/releases'

  spec.required_ruby_version = Gem::Requirement.new('>= 2.4')

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  files = Dir.chdir(__dir__) { `git ls-files -z`.split("\x0") }

  spec.files = files.grep_v(%r{^(test|spec|features)/})
  spec.test_files = files.grep(%r{^(test|spec|features)/})
  spec.bindir = "exe"
  spec.executables = files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'deface', '~> 1.0'
  spec.add_dependency 'solidus_core', ['>= 2.6.0', '< 5']
  spec.add_dependency 'solidus_support', '~> 0.5'

  spec.add_development_dependency 'coffee-rails'
  spec.add_development_dependency 'sass-rails'
  spec.add_development_dependency 'solidus_dev_support'
end
