# frozen_string_literal: true

module SpreeMultiDomain
  module Spree
    module Admin
      module ProductsControllerDecorator
        def self.prepended(base)
          base.class_eval do
            update.before :set_stores
          end
        end

        private

        def set_stores
          # Remove all store associations if store data is being passed and no stores are selected
          if params[:update_store_ids] && !params[:product].key?(:store_ids)
            @product.stores.clear
          end
        end

        if SpreeMultiDomain::Engine.admin_available?
          ::Spree::Admin::ProductsController.prepend self
        end
      end
    end
  end
end
