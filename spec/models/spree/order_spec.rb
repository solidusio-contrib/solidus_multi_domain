require 'spec_helper'

describe Spree::Order do

  before(:each) do
    @store = FactoryGirl.create(:store)
    @order = FactoryGirl.create(:order, :store => @store)

    @order2 = FactoryGirl.create(:order)
  end

  it 'should correctly find products by store' do
    by_store = Spree::Order.by_store(@store)

    by_store.should include(@order)
    by_store.should_not include(@order2)
  end
end
