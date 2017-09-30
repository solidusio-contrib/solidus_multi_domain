module SpreeMultiDomain
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
        ApplicationController.send :include, SpreeMultiDomain::MultiDomainHelpers
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
    end

    config.to_prepare &method(:activate).to_proc

    initializer "templates with dynamic layouts" do |app|
      require 'spree_multi_domain/dynamic_template_renderer'
      ActionView::TemplateRenderer.prepend(SpreeMultiDomain::DynamicTemplateRenderer)
    end

    initializer "current order decoration" do |app|
      require 'spree/core/controller_helpers/order'
      ::Spree::Core::ControllerHelpers::Order.prepend(Module.new do
        def current_order_with_multi_domain(options = {})
          options[:create_order_if_necessary] ||= false
          current_order_without_multi_domain(options)

          if @current_order and current_store and @current_order.store.blank?
            @current_order.update_attribute(:store_id, current_store.id)
          end

          @current_order
        end
      end)
    end

    initializer 'spree.promo.register.promotions.rules' do |app|
      app.config.spree.promotions.rules << Spree::Promotion::Rules::Store
    end

    # only load store views if solidus < 2.2
    if SolidusSupport.solidus_gem_version < Gem::Version.new('2.2.x')
      paths["app/views"] << "lib/views"
    end
  end
end
