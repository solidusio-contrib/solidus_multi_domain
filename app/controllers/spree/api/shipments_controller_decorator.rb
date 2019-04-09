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

if SpreeMultiDomain::Engine.api_available?
  Spree::Api::ShipmentsController.prepend(SpreeMultiStore::Api::ShipmentsControllerDecorator)
  Spree::Api::ShipmentsController.include(SpreeMultiDomain::LineItemSupport)
end
