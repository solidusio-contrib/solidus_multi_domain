module SpreeMultiDomain::LineItemDecorator
  extend ActiveSupport::Concern

  class ProductDoesNotBelongToStoreError < StandardError; end

  included do
    prepend(InstanceMethods)
    before_create :ensure_product_belongs_to_store
  end

  module InstanceMethods
    private

    def ensure_product_belongs_to_store
      raise SpreeMultiDomain::LineItemDecorator::ProductDoesNotBelongToStoreError if order.store.present? && !product.stores.include?(order.store)
    end
  end
end

Spree::LineItem.include(SpreeMultiDomain::LineItemDecorator)
