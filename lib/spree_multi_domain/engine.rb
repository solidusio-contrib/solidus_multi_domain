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

        # Previous versions of solidus have the multi domain store selection
        # logic directly in core (called Spree::Core::CurrentStore or
        # Spree::CurrentStoreSelector). As long as Spree::Config responds to
        # current_store_selector_class we can use the new domain selector
        # class safely.
        if store_selector_class?
          Spree::Config.current_store_selector_class = Spree::MultiDomainStoreSelector
        end

        Spree::Config.searcher_class = Spree::Search::MultiDomain
        ApplicationController.send :include, SpreeMultiDomain::MultiDomainHelpers
      end

      def store_selector_class?
        Spree::Config.respond_to?(:current_store_selector_class)
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
      ActionView::TemplateRenderer.prepend(Module.new do
        def find_layout(layout, *args)
          if @view.respond_to?(:current_store) && @view.current_store && !@view.controller.is_a?(Spree::Admin::BaseController)
            store_layout = if layout.is_a?(String)
                             layout.gsub("layouts/", "layouts/#{@view.current_store.code}/")
                           else
                             layout.call.try(:gsub, "layouts/", "layouts/#{@view.current_store.code}/")
                           end

            begin
              super(store_layout, *args)
            rescue ::ActionView::MissingTemplate
              super(layout, *args)
            end
          else
            super(layout, *args)
          end
        end
      end)
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
  end
end
