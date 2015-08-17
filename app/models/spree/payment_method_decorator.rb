Spree::PaymentMethod.class_eval do
  has_many :store_payment_methods
  has_many :stores, :through => :store_payment_methods

  class << self
    alias_method :available_without_store, :available
    def available(display_on = 'both', store = nil)
      available_without_store(display_on).select do |p|
        store.nil? || store.payment_methods.empty? || store.payment_methods.include?(p)
      end
    end
  end
end
