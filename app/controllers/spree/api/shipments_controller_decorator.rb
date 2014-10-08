module SpreeMultiStore
  module Api
    module ShipmentsControllerDecorator
      def self.included(base)
        base.alias_method_chain :mine, :store_scope
      end

      def mine_with_store_scope
        mine_without_store_scope
        @shipments = @shipments.where(spree_orders: { store_id: current_store.id }) if @shipments
      end
    end
  end
end

Spree::Api::ShipmentsController.include SpreeMultiStore::Api::ShipmentsControllerDecorator
