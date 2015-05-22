require 'spec_helper'

describe Spree::Order do

  before(:each) do
    @store = FactoryGirl.create(:store)
    @order = FactoryGirl.create(:order, :store => @store)

    @order2 = FactoryGirl.create(:order)
  end

  it 'should correctly find products by store' do
    by_store = Spree::Order.by_store(@store)

    expect(by_store).to include(@order)
    expect(by_store).not_to include(@order2)
  end
end
