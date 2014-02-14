require 'spec_helper'

describe Spree::ProductsController do
  let!(:product) { FactoryGirl.create(:product) }
  describe 'on :show to a product without any stores' do
    let!(:store) { FactoryGirl.create(:store) }

    it 'should return 404' do
      spree_get :show, :id => product.to_param

      response.response_code.should == 404
    end
  end

  # Regression test for #75
  describe 'on :show to a product in the wrong store' do
    let!(:store_1) { FactoryGirl.create(:store) }
    let!(:store_2) { FactoryGirl.create(:store) }

    before(:each) do
      product.stores << store_1
    end

    it 'should return 404' do
      controller.stub(:current_store => store_2)
      spree_get :show, :id => product.to_param

      response.response_code.should == 404
    end
  end

  describe 'on :show to a product w/ store' do
    let!(:store) { FactoryGirl.create(:store) }

    before(:each) do
      product.stores << store
    end

    it 'should return 200' do
      controller.stub(:current_store => store)
      spree_get :show, :id => product.to_param

      response.response_code.should == 200
    end
  end

  describe "on :show when the product hasn't been found" do
    let!(:store) { FactoryGirl.create(:store) }

    before(:each) do
      product.stores << store
    end

    it 'finds the store' do
      pending 'I cannot figure out how to get a test into this state, but it does happen in my app' do
        # the line that fixes this comes from 167d40124c9167fc7fed4c5dee1bf73fd4145b03
        # but there are no tests that hit it, ideally this test would, but I can't figure out how to write it
        spree_get :show, :id => ??
      end
    end
  end
end
