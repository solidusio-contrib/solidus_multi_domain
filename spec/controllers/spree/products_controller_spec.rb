require 'spec_helper'

describe Spree::ProductsController do
  let!(:product) { create(:product) }

  describe 'on :show to a product without any stores' do
    let!(:store) { create(:store) }

    it 'returns 404' do
      if SolidusSupport.solidus_gem_version < Gem::Version.new('2.5.x')
        get :show, params: { id: product.to_param }
        expect(response.response_code).to eq 404
      else
        expect {
          get :show, params: { :id => product.to_param }
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  # Regression test for #75
  describe 'on :show to a product in the wrong store' do
    let!(:store_1) { create(:store) }
    let!(:store_2) { create(:store) }

    before(:each) do
      product.stores << store_1
    end

    it 'returns 404' do
      allow(controller).to receive_messages(:current_store => store_2)

      if SolidusSupport.solidus_gem_version < Gem::Version.new('2.5.x')
        get :show, params: { id: product.to_param }
        expect(response.response_code).to eq 404
      else
        expect {
          get :show, params: { :id => product.to_param }
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'on :show to a product w/ store' do
    let!(:store) { create(:store) }

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
