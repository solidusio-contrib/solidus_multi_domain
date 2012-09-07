require 'spec_helper'

describe Spree::ProductsController do
  describe 'on :show to a product w/out correct store' do
    before(:each) do
      @store = FactoryGirl.create(:store)
      @product = FactoryGirl.create(:product)
    end

    it 'should return 404' do
      spree_get :show, :id => @product.to_param

      response.response_code.should == 404
    end
  end

  describe 'on :show to a product w/ store' do
    before(:each) do
      @store = FactoryGirl.create(:store)
      @product = FactoryGirl.create(:product, :stores => [@store])
    end

    it 'should return 200' do
      spree_get :show, :id => @product.to_param

      response.response_code.should == 200
    end
  end
end
