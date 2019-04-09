# frozen_string_literal: true

module SolidusMultiDomain
  module LineItemSupport
    extend ActiveSupport::Concern

    included do
      prepend(InstanceMethods)
      rescue_from SolidusMultiDomain::LineItemConcerns::ProductDoesNotBelongToStoreError, with: :product_does_not_belong_to_store
    end

    module InstanceMethods
      private

      def product_does_not_belong_to_store
        render json: { message: I18n.t('spree.errors.products_from_different_stores_may_not_be_added_to_this_order') }, status: 422
      end
    end
  end
end
