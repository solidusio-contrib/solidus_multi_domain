# frozen_string_literal: true

module SolidusMultiDomain
  module Spree
    module TaxonsHelperDecorator
      def self.prepended(base)
        base.module_eval do
          def taxon_preview(taxon, max = 4)
            price_scope = ::Spree::Price.where(current_pricing_options.search_arguments)

            products = taxon.active_products
                            .joins(:stores)
                            .where("spree_products_stores.store_id = ?", current_store.id)
                            .joins(:prices)
                            .merge(price_scope)
                            .select("DISTINCT spree_products.*, spree_products_taxons.position")
                            .limit(max)

            if products.size < max
              products_arel = ::Spree::Product.arel_table
              taxon.descendants.each do |descendent_taxon|
                to_get = max - products.length
                products += descendent_taxon.active_products
                                            .joins(:stores)
                                            .where("spree_products_stores.store_id = ?", current_store.id)
                                            .joins(:prices)
                                            .merge(price_scope)
                                            .select("DISTINCT spree_products.*, spree_products_taxons.position")
                                            .where(products_arel[:id].not_in(products.map(&:id)))
                                            .limit(to_get)
                break if products.size >= max
              end
            end

            products
          end
        end
      end

      ::Spree::TaxonsHelper.prepend self
    end
  end
end
