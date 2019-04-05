source 'https://rubygems.org'

branch = ENV.fetch('SOLIDUS_BRANCH', 'master')
gem 'solidus', github: 'solidusio/solidus', branch: branch

if branch == 'master' || branch >= 'v2.3'
  gem 'rails', '~> 5.1.0' # hack for broken bundler dependency resolution
  gem 'rails-controller-testing', group: :test
elsif branch >= 'v2.0'
  gem 'rails', '~> 5.0.0' # hack for broken bundler dependency resolution
  gem 'rails-controller-testing', group: :test
else
  gem 'rails', '~> 4.2.7'
  gem 'rails_test_params_backport', group: :test
end

case ENV['DB']
when 'mysql'
  gem 'mysql2', '~> 0.4.10'
when 'postgres'
  gem 'pg', '~> 0.21'
end

group :development, :test do
  gem 'pry-rails'

  if branch < 'v2.5'
    gem 'factory_bot', '4.10.0'
  else
    gem 'factory_bot', '> 4.10.0'
  end
end

gemspec
