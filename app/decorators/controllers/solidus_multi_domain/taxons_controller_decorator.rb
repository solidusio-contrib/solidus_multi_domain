# frozen_string_literal: true

module SolidusMultiDomain
  module TaxonsControllerDecorator
    def show
      @taxon = ::Spree::Taxon.find_by_store_id_and_permalink!(current_store.id, params[:id])
      return unless @taxon
      @searcher = build_searcher(params.merge(taxon: @taxon.id))
      @products = @searcher.retrieve_products
      @taxonomies = get_taxonomies
    end

    ::TaxonsController.prepend(self)
  end
end
