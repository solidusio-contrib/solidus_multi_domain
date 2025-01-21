# frozen_string_literal: true

module SolidusMultiDomain
  module ShowProductSupport
    extend ActiveSupport::Concern

    included do
      prepend(InstanceMethods)
      before_action :can_show_product, only: :show
    end

    module InstanceMethods
      def can_show_product
        @product ||= Spree::Product.friendly.find(params[:id])
        return unless @product.stores.empty? || !@product.stores.include?(current_store)

        raise ActiveRecord::RecordNotFound
      end
    end
  end
end
