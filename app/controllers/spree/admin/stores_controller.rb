class Spree::Admin::StoresController < Spree::Admin::ResourceController

  before_filter :load_payment_methods

  private
    def load_payment_methods
      @payment_methods = Spree::PaymentMethod.all
    end
end
