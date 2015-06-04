require 'spec_helper'

describe Spree::ProductsController do

  let!(:product) { FactoryGirl.create(:product) }

  describe 'on :show to a product without any stores' do
    let!(:store) { FactoryGirl.create(:store) }

    it 'returns 404' do
      spree_get :show, :id => product.to_param

      expect(response.response_code).to eq 404
    end
  end

  # Regression test for #75
  describe 'on :show to a product in the wrong store' do
    let!(:store_1) { FactoryGirl.create(:store) }
    let!(:store_2) { FactoryGirl.create(:store) }

    before(:each) do
      product.stores << store_1
    end

    it 'returns 404' do
      allow(controller).to receive_messages(:current_store => store_2)
      spree_get :show, :id => product.to_param

      expect(response.response_code).to eq 404
    end
  end

  describe 'on :show to a product w/ store' do
    let!(:store) { FactoryGirl.create(:store) }

    before(:each) do
      product.stores << store
    end

    it 'returns 200' do
      allow(controller).to receive_messages(:current_store => store)
      spree_get :show, :id => product.to_param

      expect(response.response_code).to eq 200
    end
  end

end
