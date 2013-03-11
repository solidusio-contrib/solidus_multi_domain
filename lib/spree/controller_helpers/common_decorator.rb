Spree::Core::ControllerHelpers::Common.class_eval do
  def current_currency
    current_store.try(:default_currency) || Spree::Config[:currency]
  end
end

