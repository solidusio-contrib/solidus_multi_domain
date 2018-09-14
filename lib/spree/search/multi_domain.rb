module Spree::Search
  class MultiDomain < Spree::Core::Search::Base
    def get_base_scope
      base_scope = @cached_product_group ? @cached_product_group.products.available : Spree::Product.available
      base_scope = base_scope.by_store(current_store_id) if current_store_id
      base_scope = base_scope.in_taxon(taxon) unless taxon.blank?

      base_scope = get_products_conditions_for(base_scope, keywords) unless keywords.blank?

      add_search_scopes(base_scope)
    end

    def prepare(params)
      super
      @properties[:current_store_id] = params[:current_store_id]
    end

    def current_store_id
      @properties[:current_store_id]
    end

    def keywords
      @properties[:keywords]
    end

    def taxon
      @properties[:taxon]
    end
  end
end
