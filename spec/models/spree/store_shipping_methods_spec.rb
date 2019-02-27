# frozen_string_literal: true

require 'spec_helper'

describe Spree::StoreShippingMethod do
  # Regression tests for https://github.com/solidusio/solidus/issues/2998
  describe 'associations' do
    it 'belongs to and is the inverse of store' do
      association = described_class.reflect_on_association(:store)

      expect(association.macro).to eq(:belongs_to)
      expect(association.options).to eq({
        :inverse_of => :store_shipping_methods
      })
    end

    it 'belongs to and is the inverse of shipping_method' do
      association = described_class.reflect_on_association(:shipping_method)

      expect(association.macro).to eq(:belongs_to)
      expect(association.options).to eq({
        :inverse_of => :store_shipping_methods
      })
    end
  end
end
