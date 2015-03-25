Spree::CartonMailer.class_eval do
  def from_address_with_multidomain
    order = @carton.orders.first

    if order.store && order.store.email.present?
      order.store.email
    else
      from_address_without_multidomain
    end
  end

  alias_method_chain :from_address, :multidomain
end
