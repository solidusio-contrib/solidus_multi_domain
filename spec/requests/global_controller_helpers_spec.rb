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

  it "should populate the params with store id" do
    request.params[:current_store_id].should == store.id
  end

  it "should create a store-aware order" do
    controller.current_store.should == store
  end

  it "should instantiate the correct store-bound tracker" do
    controller.current_tracker.should == @tracker
  end

  describe '.current_currency' do
    context "when store default_currency is nil" do
      it 'returns the global default' do
        controller.current_currency.should == 'USD'
      end
    end

    context "when the current store default_currency is not nil" do
      let!(:store) { FactoryGirl.create :store, :default_currency => 'EUR' }

      it "returns the default currency for the current store" do
        controller.current_currency.should == 'EUR'
      end
    end
  end

end
