require 'spec_helper'

describe "Global controller helpers" do

  let!(:store) { FactoryGirl.create :store }
  before(:each) do
    @tracker = FactoryGirl.create :tracker, :store => store
    get '/'
  end

  it "should include the right tracker" do
    response.body.should include(@tracker.analytics_id)
  end

  it "should create a store-aware order" do
    controller.current_store.should == store
  end

  it "should instantiate the correct store-bound tracker" do
    controller.current_tracker.should == @tracker
  end

  describe '.current_currency' do
    subject { controller.current_currency }

    context "when store default_currency is nil" do
      it { should == 'USD' }
    end

    context "when the current store default_currency empty" do
      let!(:store) { FactoryGirl.create :store, :default_currency => '' }

      it { should == 'USD' }
    end

    context "when the current store default_currency is a currency" do
      let!(:store) { FactoryGirl.create :store, :default_currency => 'EUR' }

      it { should == 'EUR' }
    end
  end

end
