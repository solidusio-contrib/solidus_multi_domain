# frozen_string_literal: true

module Spree
  module Search
    class MultiDomain < Spree::Core::Search::Base
      def get_base_scope
        base_scope = @cached_product_group ? @cached_product_group.products.available : Spree::Product.available
        base_scope = base_scope.by_store(@properties[:current_store_id]) if @properties[:current_store_id].present?
        base_scope = base_scope.in_taxon(@properties[:taxon]) if @properties[:taxon].present?

        base_scope = get_products_conditions_for(base_scope, @properties[:keywords]) if @properties[:keywords].present?

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
