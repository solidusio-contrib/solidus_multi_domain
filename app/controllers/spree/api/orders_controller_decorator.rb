module SpreeMultiStore
  module Api
    module OrdersControllerDecorator
      def self.included(base)
        base.alias_method_chain :mine, :store_scope
        base.alias_method_chain :find_current_api_user_orders, :store_scope
      end

      def mine_with_store_scope
        mine_without_store_scope
        @orders = @orders.where(store: current_store) if @orders
      end

      def find_current_api_user_orders_with_store_scope
        find_current_api_user_orders_without_store_scope.where(store: current_store)
      end
    end
  end
end

Spree::Api::OrdersController.include SpreeMultiStore::Api::OrdersControllerDecorator
