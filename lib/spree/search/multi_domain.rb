module Spree::Search
  class MultiDomain < Spree::Core::Search::Base
    def get_base_scope
      base_scope = @cached_product_group ? @cached_product_group.products.available : Spree::Product.available
      base_scope = base_scope.by_store(@properties[:current_store_id]) if @properties[:current_store_id]
      base_scope = base_scope.in_taxon(@properties[:taxon]) unless @properties[:taxon].blank?

      base_scope = get_products_conditions_for(base_scope, @properties[:keywords]) unless @properties[:keywords].blank?

      base_scope = add_search_scopes(base_scope)
      base_scope
    end

    def prepare(params)
      super
      @properties[:current_store_id] = params[:current_store_id]
    end
  end
end
