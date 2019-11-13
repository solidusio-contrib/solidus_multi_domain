# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'

require 'solidus_extension_dev_tools/rspec/coverage'

require File.expand_path('dummy/config/environment.rb', __dir__)

require 'solidus_extension_dev_tools/rspec/feature_helper'

Dir[File.join(File.dirname(__FILE__), 'support/**/*.rb')].each { |f| require f }
