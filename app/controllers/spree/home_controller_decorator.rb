module HomeControllerDecorator
  extend ActiveSupport::Concern

  included do
    def index
      @searcher = build_searcher(params)
      @products = @searcher.retrieve_products
      @taxonomies = get_taxonomies
    end
  end
end

if SpreeMultiDomain::Engine.frontend_available?
  Spree::HomeController.include(HomeControllerDecorator)
end
