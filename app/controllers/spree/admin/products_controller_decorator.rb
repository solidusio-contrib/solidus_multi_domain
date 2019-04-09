module ProductsControllerDecorator
  extend ActiveSupport::Concern

  included do
    prepend(InstanceMethod)
    update.before :set_stores
  end

  module InstanceMethod
    private

    def set_stores
      # Remove all store associations if store data is being passed and no stores are selected
      if params[:update_store_ids] && !params[:product].key?(:store_ids)
        @product.stores.clear
      end
    end
  end
end

if SolidusMultiDomain::Engine.admin_available?
  Spree::Admin::ProductsController.include(ProductsControllerDecorator)
end
