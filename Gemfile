source "https://rubygems.org"

branch = ENV.fetch('SOLIDUS_BRANCH', 'master')
gem "solidus", github: "solidusio/solidus", branch: branch
gem "rails-controller-testing", group: :test

gem 'pg'
gem 'mysql2'

group :development, :test do
  gem "pry-rails"
end

gemspec
