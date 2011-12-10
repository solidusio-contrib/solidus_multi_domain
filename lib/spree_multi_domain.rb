require 'spree_core'

module SpreeMultiDomain
  class Engine < Rails::Engine

    config.autoload_paths += %W(#{config.root}/lib)

    def self.activate

      require 'spree_multi_domain_hooks'
      #override search to make it multi-store aware
      Spree::Config.searcher_class = Spree::Search::MultiDomain

      Dir.glob(File.join(File.dirname(__FILE__), "../app/**/*_decorator*.rb")) do |c|
        Rails.env.production? ? require(c) : load(c)
      end


    end

    config.to_prepare &method(:activate).to_proc
  end
end

# Make it possible to add to existing resource controller hooks with '<<' even when there's no hook of a given type defined yet.
# e.g. create.before << :assign_to_store
ResourceController::Accessors.module_eval do
  private
  def block_accessor(*accessors)
    accessors.each do |block_accessor|
      class_eval <<-"end_eval", __FILE__, __LINE__

        def #{block_accessor}(*args, &block)
          @#{block_accessor} ||= []
          unless args.empty? && block.nil?
            args.push block if block_given?
            @#{block_accessor} = [args].flatten
          end
          @#{block_accessor}
        end

      end_eval
    end
  end
end

Spree::CurrentOrder.module_eval do
  def current_order_with_multi_domain(create_order_if_necessary = false)
    current_order_without_multi_domain(create_order_if_necessary)
    if @current_order and current_store and @current_order.store.nil?
      @current_order.update_attribute(:store_id, current_store.id)
    end
    @current_order
  end
  alias_method_chain :current_order, :multi_domain
end


module SpreeBase
  module InstanceMethods
    private

    def current_store
      @current_store ||= ::Store.current(request.env['SERVER_NAME'])
    end
    
    def current_tracker
      @current_tracker ||= Tracker.current(request.env['SERVER_NAME'])
    end

    def get_taxonomies
      @taxonomies ||= current_store.present? ? Taxonomy.where(["store_id = ?", current_store.id]) : Taxonomy
      @taxonomies = @taxonomies.find(:all, :include => {:root => :children})
      @taxonomies
    end
    
    def add_current_store_id_to_params
      params[:current_store_id] = current_store.try(:id)
    end
  end

  class << self

    def included_with_multi_domain(receiver)
      included_without_multi_domain(receiver)

      receiver.send :helper, 'products'
      receiver.send :helper, 'taxons'
      receiver.send :before_filter, 'add_current_store_id_to_params'
      receiver.send :helper_method, 'current_store'
      receiver.send :helper_method, 'current_tracker'
    end
    
    alias_method_chain :included, :multi_domain
  end
end


module ActionView
  class TemplateRenderer
    def find_layout_with_multi_store(layout, locals)
      store_layout = layout
      if respond_to?(:current_store) && current_store && !controller.is_a?(Admin::BaseController)
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
