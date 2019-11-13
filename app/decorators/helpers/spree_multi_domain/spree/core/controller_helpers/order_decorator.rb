# frozen_string_literal: true

module SpreeMultiDomain
  module Spree
    module Core
      module ControllerHelpers
        module OrderDecorator
          def self.prepended(base)
            base.module_eval do
              def current_currency
                # When using spree_multi_currency the current_currency is stored within session[:currency]
                currency = session[:currency] if session.key?(:currency) && supported_currencies.map(&:iso_code).include?(session[:currency])
                # If there is no session currency fall back to the store default
                currency ||= current_store.try(:default_currency)
                # If there is still no currency fall back to Spree default
                currency = ::Spree::Config[:currency] if currency.blank?
                currency
              end

              def current_order_with_multi_domain(options = {})
                options[:create_order_if_necessary] ||= false
                current_order_without_multi_domain(options)

                if @current_order && current_store && @current_order.store.blank?
                  @current_order.update_attribute(:store_id, current_store.id)
                end

                @current_order
              end
            end
          end

          ::Spree::Core::ControllerHelpers::Order.prepend self
        end
      end
    end
  end
end
