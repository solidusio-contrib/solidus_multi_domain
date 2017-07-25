module SpreeMultiStore
  module Api
    module ShipmentsControllerDecorator
      def mine
        super
        @shipments = @shipments.where(spree_orders: { store_id: current_store.id }) if @shipments
      end
    end
  end
end

if SolidusSupport.api_available?
  Spree::Api::ShipmentsController.prepend(SpreeMultiStore::Api::ShipmentsControllerDecorator)
  Spree::Api::ShipmentsController.include(SpreeMultiDomain::CreateLineItemSupport)
end
