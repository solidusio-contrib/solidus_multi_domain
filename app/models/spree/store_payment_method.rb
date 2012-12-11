module Spree
  class StorePaymentMethod < ActiveRecord::Base
    belongs_to :store
    belongs_to :payment_method
  end
end
