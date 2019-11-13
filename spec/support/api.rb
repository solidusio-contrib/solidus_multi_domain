
require 'spree/api/testing_support/setup'
require 'spree/api/testing_support/helpers'

RSpec.configure do |config|
  config.include Spree::TestingSupport::ControllerRequests, type: :controller
  config.include Spree::Api::TestingSupport::Helpers, type: :controller
end
