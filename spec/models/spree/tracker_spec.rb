require 'spec_helper'

describe Spree::Tracker do
  before(:each) do
    store = FactoryGirl.create(:store, :default => true)
    @tracker = FactoryGirl.create(:tracker, :store => store)

    another_store = FactoryGirl.create(:store, :code => 'STORE2', :domains => 'completely-different-store.com')
    @tracker2 = FactoryGirl.create(:tracker, :store => another_store)
  end

  it "should pull out the current tracker based on store code" do
    expect(Spree::Tracker.current('STORE2')) == @tracker
  end

  it "should pull out the current tracker based on domains" do
    expect(Spree::Tracker.current('www.example.com')) == @tracker
  end
end
