class MultiDomainExtension < Spree::Extension
  version "1.0"
  description "Describe your extension here"
  url "http://yourwebsite.com/site"

  # Please use site/config/routes.rb instead for extension routes.

  # def self.require_gems(config)
  #   config.gem "gemname-goes-here", :version => '1.2.3'
  # end

  def activate

    Spree::BaseController.send(:include, Spree::MultiDomain::BaseControllerOverrides)

    Product.class_eval do
      has_and_belongs_to_many :stores

      named_scope :by_store, lambda { |*args| { :joins => :stores, :conditions => ["products_stores.store_id = ?", args.first] } }
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

    #override search to make it multi-store aware
    Spree::Search.module_eval do
      def retrieve_products
        # taxon might be already set if this method is called from TaxonsController#show
        @taxon ||= Taxon.find_by_id(params[:taxon]) unless params[:taxon].blank?
        # add taxon id to params for searcher
        params[:taxon] = @taxon.id if @taxon
        @keywords = params[:keywords]

        per_page = params[:per_page].to_i
        per_page = per_page > 0 ? per_page : Spree::Config[:products_per_page]
        params[:per_page] = per_page
        params[:page] = 1 if (params[:page].to_i <= 0)

        # Prepare a search within the parameters
        Spree::Config.searcher.prepare(params)

        if !params[:order_by_price].blank?
          @product_group = ProductGroup.new.from_route([params[:order_by_price]+"_by_master_price"])
        elsif params[:product_group_name]
          @cached_product_group = ProductGroup.find_by_permalink(params[:product_group_name])
          @product_group = ProductGroup.new
        elsif params[:product_group_query]
          @product_group = ProductGroup.new.from_route(params[:product_group_query])
        else
          @product_group = ProductGroup.new
        end

        #SITE SPECIFIC: only retrieve products for the current store.
        @product_group.add_scope('by_store', @current_store.id)
        @product_group.add_scope('in_taxon', @taxon) unless @taxon.blank?
        @product_group.add_scope('keywords', @keywords) unless @keywords.blank?
        @product_group = @product_group.from_search(params[:search]) if params[:search]

        base_scope = @cached_product_group ? @cached_product_group.products.active : Product.active
        base_scope = base_scope.on_hand unless Spree::Config[:show_zero_stock_products]
        @products_scope = @product_group.apply_on(base_scope)

        curr_page = Spree::Config.searcher.manage_pagination ? 1 : params[:page]
        @products = @products_scope.all.paginate({
            :include  => [:images, :master],
            :per_page => per_page,
            :page     => curr_page
          })
        @products_count = @products_scope.count

        return(@products)
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
    end

    OrdersController.class_eval do
      create.before << :assign_to_store

      private
      def assign_to_store
        @order.store = @current_store
      end
    end

    # Taxonomy.class_eval do
    #   belongs_to :store
    # end

    Tracker.class_eval do
      belongs_to :store

      def self.current
        trackers = Tracker.find(:all, :conditions => {:active => true, :environment => ENV['RAILS_ENV']})
        trackers.select { |t| t.store.name == Spree::Config[:site_name] }.first
      end
    end

    # make your helper avaliable in all views
    # Spree::BaseController.class_eval do
    #   helper YourHelper
    # end
  end
end
