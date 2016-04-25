require 'spec_helper'

describe Spree::Tracker do
  before(:each) do
    @store = FactoryGirl.create(:store, default: true)
    @tracker = FactoryGirl.create(:tracker, store: @store)

    @another_store = FactoryGirl.create(:store, code: 'STORE2', url: 'completely-different-store.com')
    @tracker2 = FactoryGirl.create(:tracker, store: @another_store)
  end

  it "finds tracker by store" do
    expect(Spree::Tracker.current(@store)).to eq @tracker
  end
end
