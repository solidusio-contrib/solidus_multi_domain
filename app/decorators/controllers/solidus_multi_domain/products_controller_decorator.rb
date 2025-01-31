# frozen_string_literal: true

module SolidusMultiDomain
  module ProductsControllerDecorator
    def self.prepended(base)
      base.prepend SolidusMultiDomain::ShowProductSupport
    end

    def show
      @variants = @product.
                  variants_including_master.
                  display_includes.
                  with_prices(current_pricing_options).
                  includes([:option_values, :images])
      @taxonomies = get_taxonomies
      @product_properties = @product.product_properties.includes(:property)
      @taxon = Spree::Taxon.find(params[:taxon_id]) if params[:taxon_id]
      @similar_products = @product.similar_products.select { |product| product.stores.include?(current_store) }
    end

    ::ProductsController.prepend(self)
  end
end
