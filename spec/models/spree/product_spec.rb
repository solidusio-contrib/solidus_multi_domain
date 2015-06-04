require 'spec_helper'

describe Spree::Product do

  before(:each) do
    @store = FactoryGirl.create(:store)
    @product = FactoryGirl.create(:product, :stores => [@store])

    @product2 = FactoryGirl.create(:product, :slug => 'something else')
  end

  it 'should correctly find products by store' do
    products_by_store = Spree::Product.by_store(@store)

    expect(products_by_store).to include(@product)
    expect(products_by_store).not_to include(@product2)
  end
end
