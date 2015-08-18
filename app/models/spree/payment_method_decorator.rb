Spree::PaymentMethod.class_eval do
  has_many :store_payment_methods
  has_many :stores, :through => :store_payment_methods
end
