require 'spec_helper'

describe Spree::ProductsController do

  let!(:product) { FactoryBot.create(:product) }

  describe 'on :show to a product without any stores' do
    let!(:store) { FactoryBot.create(:store) }

    it 'returns 404' do
      get :show, params: { :id => product.to_param }

      expect(response.response_code).to eq 404
    end
  end

  # Regression test for #75
  describe 'on :show to a product in the wrong store' do
    let!(:store_1) { FactoryBot.create(:store) }
    let!(:store_2) { FactoryBot.create(:store) }

    before(:each) do
      product.stores << store_1
    end

    it 'returns 404' do
      allow(controller).to receive_messages(:current_store => store_2)
      get :show, params: { :id => product.to_param }

      expect(response.response_code).to eq 404
    end
  end

  describe 'on :show to a product w/ store' do
    let!(:store) { FactoryBot.create(:store) }

    before(:each) do
      product.stores << store
    end

    it 'returns 200' do
      allow(controller).to receive_messages(:current_store => store)
      get :show, params: { :id => product.to_param }

      expect(response.response_code).to eq 200
    end
  end

end
