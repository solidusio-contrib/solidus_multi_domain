# frozen_string_literal: true

module SpreeMultiDomain
  module Spree
    module TaxonsControllerDecorator
      def show
        @taxon = Spree::Taxon.find_by!(store_id: current_store.id, permalink: params[:id])
        return unless @taxon

        @searcher = build_searcher(params.merge(taxon: @taxon.id))
        @products = @searcher.retrieve_products
        @taxonomies = get_taxonomies
      end

      ::Spree::TaxonsController.prepend(self) if SpreeMultiDomain::Engine.frontend_available?
    end
  end
end
