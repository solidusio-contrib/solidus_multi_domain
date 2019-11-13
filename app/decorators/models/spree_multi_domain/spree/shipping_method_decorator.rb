# frozen_string_literal: true

module SpreeMultiDomain
  module Spree
    module ShippingMethodDecorator
      def self.prepended(base)
        base.class_eval do
          has_many :store_shipping_methods
          has_many :stores, through: :store_shipping_methods
        end
      end

      # This adds store_match to the list of requirements.
      # This will need to be fixed for Spree 2.0 when split shipments is added
      def available_to_order?(order, display_on = nil)
        available?(order, display_on) &&
          within_zone?(order) &&
          category_match?(order) &&
          currency_match?(order) &&
          store_match?(order)
      end

      def store_match?(order)
        order.store.shipping_methods.empty? || stores.include?(order.store)
      end

      ::Spree::ShippingMethod.prepend self
    end
  end
end
