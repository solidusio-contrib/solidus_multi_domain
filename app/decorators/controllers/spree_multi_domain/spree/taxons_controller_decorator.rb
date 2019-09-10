module SpreeMultiDomain
  module Spree
    module TaxonsControllerDecorator
      def show
        @taxon = Spree::Taxon.find_by_store_id_and_permalink!(current_store.id, params[:id])
        return unless @taxon

        @searcher = build_searcher(params.merge(:taxon => @taxon.id))
        @products = @searcher.retrieve_products
        @taxonomies = get_taxonomies
      end

      ::Spree::TaxonsController.prepend(self) if SpreeMultiDomain::Engine.frontend_available?
    end
  end
end
