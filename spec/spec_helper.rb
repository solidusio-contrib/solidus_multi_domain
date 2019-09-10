require 'simplecov'
SimpleCov.start 'rails'

ENV['RAILS_ENV'] ||= 'test'

require File.expand_path("../dummy/config/environment.rb",  __FILE__)

require 'solidus_support/extension/feature_helper'

require 'capybara/rspec'
require 'cancan/matchers'

require 'spree/testing_support/controller_requests'
require 'spree/testing_support/authorization_helpers'
require 'spree/testing_support/capybara_ext'
require 'spree/api/testing_support/setup'
require 'spree/api/testing_support/helpers'

require 'spree_multi_domain/testing_support/factory_overrides'

Dir[File.join(File.dirname(__FILE__), "support/**/*.rb")].each { |f| require f }

FactoryBot.use_parent_strategy = false

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!
  config.use_transactional_fixtures = false

  config.include Spree::TestingSupport::ControllerRequests, type: :controller
  config.include Spree::Api::TestingSupport::Helpers, type: :controller
end
