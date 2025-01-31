# frozen_string_literal: true

module Spree
  module Search
    class MultiDomain < Spree::Core::Search::Base
      def get_base_scope
        base_scope = Spree::Product.display_includes.available

        # This has been added to scope the search to the current store
        base_scope = base_scope.by_store(@properties[:current_store_id]) if @properties[:current_store_id].present?

        base_scope = base_scope.in_taxon(@properties[:taxon]) if @properties[:taxon].present?
        base_scope = get_products_conditions_for(base_scope, @properties[:keywords])
        base_scope = add_search_scopes(base_scope)
        add_eagerload_scopes(base_scope)
      end

      def prepare(params)
        super
        @properties[:current_store_id] = params[:current_store_id]
      end
    end
  end
end
