Spree::Core::ControllerHelpers::Order.class_eval do
  def current_currency
    # When using spree_multi_currency the current_currency is stored within session[:currency]
    currency = session[:currency] if session.key?(:currency) && supported_currencies.map(&:iso_code).include?(session[:currency])
    # If there is no session currency fall back to the store default
    currency ||= current_store.try(:default_currency)
    # If there is still no currency fall back to Spree default
    currency = Spree::Config[:currency] if currency.blank?
    currency
  end
end
