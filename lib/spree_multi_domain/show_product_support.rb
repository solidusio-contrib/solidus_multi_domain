# frozen_string_literal: true

module SpreeMultiDomain
  module ShowProductSupport
    def self.prepended(base)
      base.class_eval do
        before_action :can_show_product, only: :show
      end
    end

    private

    def can_show_product
      @product ||= ::Spree::Product.friendly.find(params[:id])
      if @product.stores.empty? || !@product.stores.include?(current_store)
        raise ActiveRecord::RecordNotFound
      end
    end
  end
end
