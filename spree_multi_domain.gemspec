Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_multi_domain'
  s.version     = '3.0.3'
  s.summary     = 'Adds multiple site support to Spree'
  s.description = 'Multiple Spree stores on different domains - single unified backed for processing orders.'
  s.required_ruby_version = '>= 1.8.7'

  s.author            = 'Brian Quinn'
  s.email             = 'brian@railsdog.com'
  s.homepage          = 'http://spreecommerce.com'
  s.rubyforge_project = 'spree_multi_domain'

  s.files        = Dir['CHANGELOG', 'README.md', 'LICENSE', 'lib/**/*', 'app/**/*', 'db/*', 'config/*']
  s.require_path = 'lib'
  s.requirements << 'none'

  s.has_rdoc = false

  s.add_dependency('spree_core',  '>= 0.30.1')
end
