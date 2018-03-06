Spree::Stock::Estimator.class_eval do
  if SolidusSupport.solidus_gem_version < Gem::Version.new('2.5.x')
    def shipping_methods(package)
      package.shipping_methods
        .available_to_store(package.shipment.order.store)
        .available_for_address(package.shipment.order.ship_address)
        .includes(:calculator, tax_category: :tax_rates)
        .to_a
        .select do |ship_method|
        calculator = ship_method.calculator
        calculator.available?(package) &&
          (calculator.preferences[:currency].blank? ||
           calculator.preferences[:currency] == package.shipment.order.currency)
      end
    end
  end
end
