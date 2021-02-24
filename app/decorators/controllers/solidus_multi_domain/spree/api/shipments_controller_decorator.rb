# frozen_string_literal: true

module SolidusMultiDomain
  module Spree
    module Api
      module ShipmentsControllerDecorator
        def self.prepended(base)
          base.prepend SolidusMultiDomain::CreateLineItemSupport
        end

        def mine
          super
          @shipments = @shipments.where(spree_orders: { store_id: current_store.id }) if @shipments
        end

        ::Spree::Api::ShipmentsController.prepend(self) if SolidusMultiDomain::Engine.api_available?
      end
    end
  end
end
