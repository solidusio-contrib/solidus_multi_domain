require 'sass/rails'
require 'spree_core'
require 'spree_multi_domain/engine'

module SpreeMultiDomain
  def self.payment_methods_by_store(payment_methods, store)
    payment_methods.select do |p|
      store.nil? ||
        store.payment_methods.empty? ||
        store.payment_methods.include?(p)
    end
  end
end
