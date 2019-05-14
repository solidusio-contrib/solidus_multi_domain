module SolidusMultiDomain
  class Engine < Rails::Engine
    engine_name 'solidus_multi_domain'

    config.autoload_paths += %W(#{config.root}/lib)

    class << self
      def activate
        ['app', 'lib'].each do |dir|
          Dir.glob(File.join(File.dirname(__FILE__), "../../#{dir}/**/*_decorator*.rb")) do |c|
            Rails.application.config.cache_classes ? require(c) : load(c)
          end
        end

        Spree::Config.searcher_class = Spree::Search::MultiDomain
        ApplicationController.send :include, SolidusMultiDomain::MultiDomainHelpers
      end

      def admin_available?
        const_defined?('Spree::Backend::Engine')
      end

      def api_available?
        const_defined?('Spree::Api::Engine')
      end

      def frontend_available?
        const_defined?('Spree::Frontend::Engine')
      end

      def stores_controller_available?
        const_defined?('Spree::Admin::Stores')
      end
    end

    config.to_prepare &method(:activate).to_proc

    initializer "templates with dynamic layouts" do |app|
      require 'solidus_multi_domain/dynamic_template_renderer'
      ActionView::TemplateRenderer.prepend(SolidusMultiDomain::DynamicTemplateRenderer)
    end

    initializer "current order decoration" do |app|
      require 'spree/core/controller_helpers/order'
      ::Spree::Core::ControllerHelpers::Order.prepend(Spree::ControllerHelpers::OrderDecorator)
    end

    initializer 'spree.promo.register.promotions.rules' do |app|
      app.config.spree.promotions.rules << Spree::Promotion::Rules::Store
    end
  end
end
