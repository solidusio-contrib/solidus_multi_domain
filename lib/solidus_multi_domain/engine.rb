# frozen_string_literal: true

require 'spree/core'

module SolidusMultiDomain
  class Engine < Rails::Engine
    include SolidusSupport::EngineExtensions::Decorators

    isolate_namespace ::Spree

    engine_name 'solidus_multi_domain'

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    def self.activate
      ::Spree::Config.searcher_class = ::Spree::Search::MultiDomain
      ApplicationController.include SolidusMultiDomain::MultiDomainHelpers
    end

    config.to_prepare &method(:activate).to_proc

    initializer 'spree.promo.register.promotions.rules' do |app|
      app.config.spree.promotions.rules << ::Spree::Promotion::Rules::Store
    end

    def self.admin_available?
      const_defined?('::Spree::Backend::Engine')
    end

    def self.api_available?
      const_defined?('::Spree::Api::Engine')
    end

    def self.frontend_available?
      const_defined?('::Spree::Frontend::Engine')
    end
  end
end
