require 'simplecov'
SimpleCov.start 'rails'

ENV['RAILS_ENV'] ||= 'test'

require File.expand_path("../dummy/config/environment.rb",  __FILE__)

require 'rspec/rails'
require 'ffaker'

require 'database_cleaner'
require 'capybara/rspec'
require 'capybara-screenshot/rspec'
require 'selenium/webdriver'

Capybara.register_driver(:selenium_chrome_headless) do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    chromeOptions: { args: %w[headless start-maximized] }
  )

  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    desired_capabilities: capabilities
  )
end

Capybara.javascript_driver = :selenium_chrome_headless
Capybara.default_max_wait_time = 10

# Requires factories defined in spree_core
require 'spree/testing_support/factories'
require 'spree_multi_domain/testing_support/factory_overrides'
require 'spree/testing_support/controller_requests'
require 'spree/testing_support/authorization_helpers'
require 'spree/testing_support/preferences'
require 'spree/api/testing_support/helpers'
require 'spree/api/testing_support/setup'
require 'spree/testing_support/capybara_ext'

require 'cancan/matchers'

Dir[File.join(File.dirname(__FILE__), "support/**/*.rb")].each { |f| require f }

FactoryBot.use_parent_strategy = false

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!
  config.mock_with :rspec

  config.filter_run focus: true
  config.run_all_when_everything_filtered = true
  config.use_transactional_fixtures = false

  config.include FactoryBot::Syntax::Methods
  config.include Spree::TestingSupport::ControllerRequests, type: :controller
  config.include Spree::Api::TestingSupport::Helpers, type: :controller

  config.before :suite do
    DatabaseCleaner.clean_with :truncation
  end

  config.before do
    DatabaseCleaner.strategy = RSpec.current_example.metadata[:js] ? :truncation : :transaction
    DatabaseCleaner.start
  end

  config.after do
    DatabaseCleaner.clean
  end
end
