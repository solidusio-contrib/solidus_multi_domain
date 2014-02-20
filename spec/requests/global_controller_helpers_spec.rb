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

    context "when session[:currency] set by spree_multi_currency" do

      before do
        session[:currency] = 'AUD'
      end

      let!(:aud) { ::Money::Currency.find('AUD') }
      let!(:eur) { ::Money::Currency.find('EUR') }
      let!(:usd) { ::Money::Currency.find('USD') }
      let!(:store) { FactoryGirl.create :store, :default_currency => 'EUR' }

      it 'returns supported currencies' do
        controller.stub(:supported_currencies).and_return([aud, eur, usd])
        expect(controller.current_currency).to eql('AUD')
      end

      it 'returns store currency if not supported' do
        controller.stub(:supported_currencies).and_return([eur, usd])
        expect(controller.current_currency).to eql('EUR')
      end
    end
  end

end
