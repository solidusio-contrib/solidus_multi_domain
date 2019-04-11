# frozen_string_literal: true

require 'capybara/rspec'
require 'capybara/rails'
require 'capybara/poltergeist'
require 'capybara-screenshot/rspec'

RSpec.configure do |config|
  Capybara.default_max_wait_time = 10
  Capybara.javascript_driver = :poltergeist

  Capybara.register_driver(:poltergeist) do |app|
    Capybara::Poltergeist::Driver.new app, js_errors: true, timeout: 90
  end

  config.before(:each, :js) do
    if Capybara.javascript_driver == :selenium
      page.driver.browser.manage.window.maximize
    end
  end
end
