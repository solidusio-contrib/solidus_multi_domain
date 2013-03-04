Spree::PaymentMethod.class_eval do
  has_many :store_payment_methods
  has_many :stores, :through => :store_payment_methods

  def self.available(display_on = 'both', store = nil)
    result = all.select do |p|
      p.active &&
        (p.environment == Rails.env || p.environment.blank?) &&
        (store.nil? || store.payment_methods.empty? || store.payment_methods.include?(p)) &&
        (p.display_on == display_on.to_s || p.display_on.blank?)
    end
  end
end
