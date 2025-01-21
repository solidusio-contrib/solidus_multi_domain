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

    initializer "solidus_multi_domain.add_admin_order_index_component" do
      if SolidusSupport.admin_available?
        config.to_prepare do
          SolidusAdmin::Config.components["orders/index"] = "SolidusMultiDomain::Orders::Index::Component"
        end
      end
    end

    def self.activate
      ::Spree::Config.searcher_class = ::Spree::Search::MultiDomain
      ApplicationController.include SolidusMultiDomain::MultiDomainHelpers
    end

    config.to_prepare(&method(:activate).to_proc)

    def self.admin_available?
      const_defined?('::Spree::Backend::Engine')
    end

    def self.api_available?
      const_defined?('::Spree::Api::Engine')
    end
  end
end
