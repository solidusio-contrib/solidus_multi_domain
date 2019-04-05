ENV['RAILS_ENV'] ||= 'test'

begin
  require File.expand_path('../dummy/config/environment', __FILE__)
rescue LoadError
  puts 'Could not load dummy application. Please ensure you have run `bundle exec rake test_app`'
  exit
end

require 'rspec/rails'
require 'ffaker'
require 'pry'
require 'cancan/matchers'

Dir[File.join(File.dirname(__FILE__), 'support/**/*.rb')].each { |f| require f }

require 'solidus_multi_domain/factories'

RSpec.configure do |config|
  config.fail_fast = false
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true

  config.mock_with :rspec
  config.raise_errors_for_deprecations!
  config.infer_spec_type_from_file_location!

  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end
end

