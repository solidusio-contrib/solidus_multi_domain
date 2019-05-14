# frozen_string_literal: true

module ShipmentsControllerDecorator
  def mine
    super
    @shipments = @shipments.where(spree_orders: { store_id: current_store.id }) if @shipments
  end
end

if SolidusMultiDomain::Engine.api_available?
  Spree::Api::ShipmentsController.prepend(ShipmentsControllerDecorator)
  Spree::Api::ShipmentsController.include(SolidusMultiDomain::CreateLineItemSupport)
end
