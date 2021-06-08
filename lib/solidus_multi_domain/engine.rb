# frozen_string_literal: true

require 'spree/core'

module SolidusMultiDomain
  class Engine < Rails::Engine
    include SolidusSupport::EngineExtensions

    isolate_namespace ::Spree

    engine_name 'solidus_multi_domain'

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    def self.activate
      # Previous versions of solidus has the multi domain store selection
      # logic directly in core (called Spree::Core::CurrentStore or
      # Spree::CurrentStoreSelector). As long as Spree::Config responds to
      # current_store_selector_class we can use the new domain selector
      # class safely.
      if ::Spree::Config.respond_to?(:current_store_selector_class)
        ::Spree::Config.current_store_selector_class = ::Spree::StoreSelector::Legacy
      end

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
