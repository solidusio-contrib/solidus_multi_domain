Spree::ShippingMethod.class_eval do
  has_many :store_shipping_methods
  has_many :stores, :through => :store_shipping_methods

  if SolidusSupport.solidus_gem_version < Gem::Version.new('2.5.x')
    scope :available_to_store, ->(store) do
      raise ArgumentError, "You must provide a store" if store.nil?
      store.shipping_methods.empty? ? all : where(id: store.shipping_method_ids)
    end
  end

  # This adds store_match to the list of requirements.
  # This will need to be fixed for Spree 2.0 when split shipments is added
  def available_to_order?(order, display_on= nil)
    available?(order, display_on) &&
    within_zone?(order) &&
    category_match?(order) &&
    currency_match?(order) &&
    store_match?(order)
  end

  def store_match?(order)
    order.store.shipping_methods.empty? || stores.include?(order.store)
  end
end
