require 'spec_helper'

describe Spree::Tracker do
  before(:each) do
    store = FactoryGirl.create(:store)
    @tracker = FactoryGirl.create(:tracker, :store => store)

    another_store = FactoryGirl.create(:store, :domains => 'completely-different-store.com')
    @tracker2 = FactoryGirl.create(:tracker, :store => another_store)
  end

  it "should pull out the current tracker" do
    expect(Spree::Tracker.current('www.example.com')) == @tracker
  end
end
