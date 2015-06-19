require 'spec_helper'

describe Spree::Tracker do
  before(:each) do
    @store = FactoryGirl.create(:store, default: true)
    @tracker = FactoryGirl.create(:tracker, store: @store)

    @another_store = FactoryGirl.create(:store, code: 'STORE2', url: 'completely-different-store.com')
    @tracker2 = FactoryGirl.create(:tracker, store: @another_store)
  end

  it "pulls out the current tracker based on store code" do
    expect(Spree::Tracker.current('STORE2')).to eq @tracker2
  end

  it "pulls out the current tracker" do
    expect(Spree::Tracker.current(@store.url)).to eq @tracker
  end
end
