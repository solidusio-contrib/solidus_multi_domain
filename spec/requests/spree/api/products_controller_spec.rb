require 'spec_helper'

describe Spree::Api::ProductsController, type: :request do

  let!(:product) { FactoryGirl.create(:product) }
  let!(:user)  { create(:user, :api) }
  let!(:store) { FactoryGirl.create(:store) }

  subject {
    get "/api/products/#{product.to_param}", params: nil, headers: {
      'X-Spree-Token' => user.spree_api_key
    }
  }

  describe 'on :show to a product without any stores' do
    let!(:store) { FactoryGirl.create(:store) }

    it 'should return 404' do
      subject
      expect(response.response_code).to eq(404)
    end
  end

  # Regression test for #75
  context 'product in stores' do
    before(:each) do
      product.stores << store
    end

    describe 'on :show to a product in the wrong store' do
      let!(:store_2) { FactoryGirl.create(:store) }

      it 'should return 404' do
        host! store_2.url
        subject
        expect(response.response_code).to eq(404)
      end
    end

    describe 'on :show to a product w/ store' do
      it 'should return 200' do
        allow(controller).to receive_messages(:current_store => store)
        subject
        expect(response.response_code).to eq(200)
      end
    end

  end
end
