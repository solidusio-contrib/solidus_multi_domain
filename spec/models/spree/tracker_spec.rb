require 'spec_helper'

describe Spree::Tracker do
  before(:each) do
    store = Factory(:store)
    @tracker = Factory(:tracker, :store => store)
    
    another_store = Factory(:store, :domains => 'completely-different-store.com')
    @tracker2 = Factory(:tracker, :store => another_store)
  end
  
  it "should pull out the current tracker" do
    Spree::Tracker.current('www.example.com').should == @tracker
  end
end
