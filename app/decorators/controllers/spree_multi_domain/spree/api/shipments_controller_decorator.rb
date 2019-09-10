module SpreeMultiStore
  module Api
    module ShipmentsControllerDecorator
      def self.prepended(base)
        base.prepend SpreeMultiDomain::CreateLineItemSupport
      end

      def mine
        super
        @shipments = @shipments.where(spree_orders: { store_id: current_store.id }) if @shipments
      end

      ::Spree::Api::ShipmentsController.prepend(self) if SpreeMultiDomain::Engine.api_available?
    end
  end
end
