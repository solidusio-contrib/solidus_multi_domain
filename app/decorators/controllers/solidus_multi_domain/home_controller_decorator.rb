# frozen_string_literal: true

module SolidusMultiDomain
  module HomeControllerDecorator
    def index
      @searcher = build_searcher(params)
      @products = @searcher.retrieve_products
      @taxonomies = get_taxonomies
      # Split products into groups of 3 for the homepage blocks.
      # You probably want to remove this logic and use your own!
      homepage_groups = @products.in_groups_of(3, false)
      @featured_products = homepage_groups[0]
      @collection_products = homepage_groups[1]
      @cta_collection_products = homepage_groups[2]
      @new_arrivals = homepage_groups[3]
    end

    ::HomeController.prepend(self)
  end
end
