module Spree::Search
  class MultiDomain < Spree::Core::Search::Base
    def get_base_scope
      base_scope = super
      base_scope = base_scope.by_store(@properties[:current_store_id]) if @properties[:current_store_id]
      base_scope
    end

    def prepare(params)
      super
      @properties[:current_store_id] = params[:current_store_id]
    end
  end
end
