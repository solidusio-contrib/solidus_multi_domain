# frozen_string_literal: true

module Spree
  module Search
    class MultiDomain < Spree::Core::Search::Base
      def get_base_scope
        base_scope = @cached_product_group ? @cached_product_group.products.available : Spree::Product.available
        base_scope = base_scope.by_store(current_store_id) if current_store_id
        base_scope = base_scope.in_taxon(taxon) if taxon.present?

        base_scope = get_products_conditions_for(base_scope, keywords) if keywords.present?

        base_scope = add_search_scopes(base_scope)
        base_scope
      end

      def prepare(params)
        super
        @properties[:current_store_id] = params[:current_store_id]
      end
    end
  end
end
