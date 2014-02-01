Spree::Core::ControllerHelpers::Order.class_eval do
  def current_currency
    currency = current_store.try(:default_currency)
    currency = Spree::Config[:currency] if currency.blank?
    currency
  end
end

