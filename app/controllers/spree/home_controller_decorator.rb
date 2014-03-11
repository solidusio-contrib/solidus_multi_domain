Spree::HomeController.class_eval do
  def index
    @searcher = build_searcher(params)
    @products = @searcher.retrieve_products
    @taxonomies = get_taxonomies
  end
end