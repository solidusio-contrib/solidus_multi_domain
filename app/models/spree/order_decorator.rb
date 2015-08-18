Spree::Order.class_eval do
  def available_payment_methods
    @available_payment_methods ||=
      SpreeMultiDomain.payment_methods_by_store(
        Spree::PaymentMethod.available(:front_end),
        store,
      )
  end
end
