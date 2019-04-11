# frozen_string_literal: true

require 'spree/testing_support/factories'
require 'spree/testing_support/controller_requests'
require 'spree/testing_support/authorization_helpers'
require 'spree/testing_support/url_helpers'
require 'spree/testing_support/preferences'
require 'spree/api/testing_support/helpers'
require 'spree/api/testing_support/setup'
require 'spree/testing_support/capybara_ext'

RSpec.configure do |config|
  config.include Spree::TestingSupport::ControllerRequests, type: :controller
  config.include Spree::TestingSupport::UrlHelpers
  config.include Spree::Api::TestingSupport::Helpers, type: :controller
end
