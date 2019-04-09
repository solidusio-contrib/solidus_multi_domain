# frozen_string_literal: true

module HomeControllerDecorator
  def index
    @searcher = build_searcher(params)
    @products = @searcher.retrieve_products
    @taxonomies = get_taxonomies
  end
end

if SolidusMultiDomain::Engine.frontend_available?
  Spree::HomeController.prepend(HomeControllerDecorator)
end
