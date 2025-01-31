# frozen_string_literal: true

module SolidusMultiDomain
  module ShowProductSupport
    def self.prepended(base)
      base.class_eval do
        before_action :can_show_product, only: :show
      end
    end

    private

    def can_show_product
      @product ||= ::Spree::Product.friendly.find(params[:id])
      return unless @product.stores.empty? || !@product.stores.include?(current_store)

      raise ActiveRecord::RecordNotFound
    end
  end
end
