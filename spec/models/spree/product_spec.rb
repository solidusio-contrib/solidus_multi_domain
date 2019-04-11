# frozen_string_literal: true

require 'spec_helper'

describe Spree::Product do

  before(:each) do
    @store = FactoryBot.create(:store)
    @product = FactoryBot.create(:product, :stores => [@store])

    @product2 = FactoryBot.create(:product, :slug => 'something else')
  end

  it 'should correctly find products by store' do
    products_by_store = Spree::Product.by_store(@store)

    expect(products_by_store).to include(@product)
    expect(products_by_store).to_not include(@product2)
  end
end
