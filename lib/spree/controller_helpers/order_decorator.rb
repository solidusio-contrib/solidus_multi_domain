module Spree
  module ControllerHelpers
    module OrderDecorator
      def current_order_with_multi_domain(options = {})
        options[:create_order_if_necessary] ||= false
        current_order_without_multi_domain(options)

        if @current_order and current_store and @current_order.store.blank?
          @current_order.update_attribute(:store_id, current_store.id)
        end

        @current_order
      end

      def current_pricing_options
        currency = session[:currency] if session.key?(:currency)
        currency = current_store.try!(:default_currency).presence || Spree::Config[:currency] if currency.blank?

        Spree::Config.pricing_options_class.new(
          currency: currency,
          country_iso: current_store.try!(:cart_tax_country_iso).presence
        )
      end
    end
  end
end
