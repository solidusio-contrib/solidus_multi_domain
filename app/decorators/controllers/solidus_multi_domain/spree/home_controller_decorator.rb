# frozen_string_literal: true

module SolidusMultiDomain
  module Spree
    module HomeControllerDecorator
      def index
        @searcher = build_searcher(params)
        @products = @searcher.retrieve_products
        @taxonomies = get_taxonomies
      end

      ::Spree::HomeController.prepend(self) if SolidusMultiDomain::Engine.frontend_available?
    end
  end
end
