# frozen_string_literal: true

module SolidusMultiDomain
  module Spree
    module ProductDecorator
      def self.prepended(base)
        base.class_eval do
          has_and_belongs_to_many :stores, join_table: 'spree_products_stores'

          scope :by_store, lambda { |store| joins(:stores).where("spree_products_stores.store_id = ?", store) }
        end
      end

      ::Spree::Product.prepend self
    end
  end
end
