# frozen_string_literal: true

module Spree
  module Search
    class MultiDomain < Spree::Core::Search::Base
      attr_accessor :current_store

      def get_base_scope
        base_scope = @cached_product_group ? @cached_product_group.products.available : Spree::Product.available
        base_scope = base_scope.by_store(current_store) if current_store
        base_scope = base_scope.in_taxon(@properties[:taxon]) unless @properties[:taxon].blank?
        base_scope = get_products_conditions_for(base_scope, @properties[:keywords])
        base_scope = add_search_scopes(base_scope)
        base_scope = add_eagerload_scopes(base_scope)
        base_scope
      end
    end
  end
end
