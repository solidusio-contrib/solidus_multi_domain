require 'spec_helper'

describe Spree::Order do
  
  before(:each) do
    @store = Factory(:store)
    @order = Factory(:order, :store => @store)
    
    @order2 = Factory(:order)
  end
  
  it 'should correctly find products by store' do
    by_store = Spree::Order.by_store(@store).all

    by_store.should include(@order)
    by_store.should_not include(@order2)
  end
end
