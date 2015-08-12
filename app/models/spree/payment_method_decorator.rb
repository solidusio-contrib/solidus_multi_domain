Spree::PaymentMethod.available_extra_conditions = -> (payment_method, options) do
  store = options[:store]
  store.nil? || store.payment_methods.empty? || store.payment_methods.include?(payment_method)
end

Spree::PaymentMethod.class_eval do
  has_many :store_payment_methods
  has_many :stores, :through => :store_payment_methods
end
