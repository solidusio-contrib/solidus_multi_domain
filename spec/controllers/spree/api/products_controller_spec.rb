require 'spec_helper'

describe Spree::Api::ProductsController do

  let!(:product) { FactoryGirl.create(:product) }

  let(:user)  { create(:user) }
  before { allow(controller).to receive(:current_spree_user) { user } }

  describe 'on :show to a product without any stores' do
    let!(:store) { FactoryGirl.create(:store) }

    it 'should return 404' do
      get :show, params: { :id => product.to_param, format: :json }

      expect(response.response_code) == 404
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
      allow(controller).to receive_messages(:current_store => store_2)
      get :show, params: { :id => product.to_param , format: :json }

      expect(response.response_code) == 404
    end
  end

  describe 'on :show to a product w/ store' do
    let!(:store) { FactoryGirl.create(:store) }

    before(:each) do
      product.stores << store
    end

    it 'should return 200' do
      allow(controller).to receive_messages(:current_store => store)
      get :show, params: { :id => product.to_param , format: :json }

      expect(response.response_code) == 200
    end
  end

end
