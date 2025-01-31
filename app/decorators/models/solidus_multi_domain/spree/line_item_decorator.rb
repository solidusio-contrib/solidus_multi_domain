# frozen_string_literal: true

module SolidusMultiDomain
  module Spree
    module LineItemDecorator
      def self.prepended(base)
        base.class_eval do
          before_create :ensure_product_belongs_to_store
        end
      end

      private

      def ensure_product_belongs_to_store
        return unless order.store.present? && !product.stores.include?(order.store)

        raise ProductDoesNotBelongToStoreError
      end

      ::Spree::LineItem.prepend self
    end
  end
end
