require "spree_multi_domain"

module SpreeMultiDomain

  class Engine < Rails::Engine

    def self.activate

      #override search to make it multi-store aware
      Spree::Config.searcher_class = Spree::Search::MultiDomain

      Spree::BaseController.class_eval do
        helper_method :current_store
        helper :products, :taxons
        before_filter :add_current_store_id_to_params
        private

        # Tell Rails to look in layouts/#{@store.code} whenever we're inside of a store (instead of the standard /layouts location)
        def find_layout(layout, format, html_fallback=false) #:nodoc:
          layout_dir = current_store ? "layouts/#{current_store.code.downcase}" : "layouts"
          view_paths.find_template(layout.to_s =~ /\A\/|layouts\// ? layout : "#{layout_dir}/#{layout}", format, html_fallback)
        rescue ActionView::MissingTemplate
          raise if Mime::Type.lookup_by_extension(format.to_s).html?
        end

        def current_store
          @current_store ||= ::Store.by_domain(request.env['SERVER_NAME']).first
          @current_store ||= ::Store.default.first
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

      Product.class_eval do
        has_and_belongs_to_many :stores
        scope :by_store, lambda {|store| joins(:stores).where("products_stores.store_id = ?", store)}
      end

      ProductsController.class_eval do
        before_filter :can_show_product, :only => :show

        private
        def can_show_product
         if @product.stores.empty? || @product.stores.include?(@site)
           render :file => "public/404.html", :status => 404
         end
        end

      end

      Admin::ProductsController.class_eval do
        update.before << :set_stores

        create.before << :add_to_all_stores

        private
        def set_stores
          @product.store_ids = nil unless params[:product].key? :store_ids
        end

        def add_to_all_stores
        end
      end

      Order.class_eval do
        belongs_to :store
        scope :by_store, lambda { |store| where(:store_id => store.id) }
      end

      Taxonomy.class_eval do
        belongs_to :store
      end

      Tracker.class_eval do
        belongs_to :store

        def self.current
          trackers = Tracker.find(:all, :conditions => {:active => true, :environment => ENV['RAILS_ENV']})
          trackers.select { |t| t.store.name == Spree::Config[:site_name] }.first
        end
      end
    end

    config.autoload_paths += %W(#{config.root}/lib)
    config.to_prepare &method(:activate).to_proc

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

