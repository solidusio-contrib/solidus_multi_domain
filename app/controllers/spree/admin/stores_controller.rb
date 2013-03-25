class Spree::Admin::StoresController < Spree::Admin::ResourceController

  before_filter :load_payment_methods
  before_filter :load_shipping_methods

  private
    def load_payment_methods
      @payment_methods = Spree::PaymentMethod.all
    end

    def load_shipping_methods
      @shipping_methods = Spree::ShippingMethod.all
    end
end
