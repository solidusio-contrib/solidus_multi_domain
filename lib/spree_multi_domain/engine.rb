module SpreeMultiDomain
  class Engine < Rails::Engine
    engine_name 'spree_multi_domain'

    config.autoload_paths += %W(#{config.root}/lib)

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../../app/**/*_decorator*.rb")) do |c|
        Rails.application.config.cache_classes ? require(c) : load(c)
      end
      
      Spree::Config.searcher_class = Spree::Search::MultiDomain
    end

    config.to_prepare &method(:activate).to_proc
    
    initializer "templates with dynamic layouts" do |app|
      ActionView::TemplateRenderer.class_eval do
        def find_layout_with_multi_store(layout, locals)
          store_layout = layout
          
          if respond_to?(:current_store) && current_store && !controller.is_a?(Spree::Admin::BaseController)
            store_layout = layout.gsub("layouts/", "layouts/#{current_store.code}/")
          end
          
          begin
            find_layout_without_multi_store(store_layout, locals)
          rescue ::ActionView::MissingTemplate
            find_layout_without_multi_store(layout, locals)
          end
        end

        alias_method_chain :find_layout, :multi_store
      end
    end
    
    initializer "current order decoration" do |app|
      ::Spree::Core::CurrentOrder.module_eval do
        def current_order_with_multi_domain(create_order_if_necessary = false)
          current_order_without_multi_domain(create_order_if_necessary)
          
          if @current_order and current_store and @current_order.store.nil?
            @current_order.update_attribute(:store_id, current_store.id)
          end
          
          @current_order
        end
        alias_method_chain :current_order, :multi_domain
      end
    end
    
    initializer "controller helpers decoration" do |app|
      ::Spree::Core::ControllerHelpers.module_eval do

        def current_store
          @current_store ||= Spree::Store.current(request.env['SERVER_NAME'])
        end
        
        def current_tracker
          @current_tracker ||= Spree::Tracker.current(request.env['SERVER_NAME'])
        end

        def get_taxonomies
          @taxonomies ||= current_store.present? ? Spree::Taxonomy.where(["store_id = ?", current_store.id]) : Spree::Taxonomy
          @taxonomies = @taxonomies.includes(:root => :children)
          @taxonomies
        end
        
        def add_current_store_id_to_params
          params[:current_store_id] = current_store.try(:id)
        end

        class << self

          def included_with_multi_domain(receiver)
            included_without_multi_domain(receiver)

            receiver.send :helper, 'spree/products'
            receiver.send :helper, 'spree/taxons'
            receiver.send :before_filter, 'add_current_store_id_to_params'
            receiver.send :helper_method, 'current_store'
            receiver.send :helper_method, 'current_tracker'
          end
          
          alias_method_chain :included, :multi_domain
        end
      end
    end
  end
end
