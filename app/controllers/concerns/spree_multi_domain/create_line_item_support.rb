module SpreeMultiDomain::CreateLineItemSupport
  extend ActiveSupport::Concern

  included do
    prepend(InstanceMethods)
    rescue_from SpreeMultiDomain::LineItemConcerns::ProductDoesNotBelongToStoreError, with: :product_does_not_belong_to_store
  end

  module InstanceMethods
    private

    def product_does_not_belong_to_store
      render json: { message: Spree.t('errors.products_from_different_stores_may_not_be_added_to_this_order') }, status: 422
    end
  end
end
