# frozen_string_literal: true

module SpreeMultiDomain
  module Spree
    module HomeControllerDecorator
      def index
        @searcher = build_searcher(params)
        @products = @searcher.retrieve_products
        @taxonomies = get_taxonomies
      end

      ::Spree::HomeController.prepend(self) if SpreeMultiDomain::Engine.frontend_available?
    end
  end
end
