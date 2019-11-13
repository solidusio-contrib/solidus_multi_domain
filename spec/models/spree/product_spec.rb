# frozen_string_literal: true

require 'spec_helper'

describe Spree::Product do
  before do
    @store = FactoryBot.create(:store)
    @product = FactoryBot.create(:product, stores: [@store])

    @product2 = FactoryBot.create(:product, slug: 'something else')
  end

  it 'correctlies find products by store' do
    products_by_store = described_class.by_store(@store)

    expect(products_by_store).to include(@product)
    expect(products_by_store).not_to include(@product2)
  end
end
