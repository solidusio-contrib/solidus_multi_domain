require 'spec_helper'

describe Spree::Api::ProductsController, type: :request do

  let!(:product) { FactoryBot.create(:product) }
  let!(:user)  { create(:user, :with_api_key) }
  let!(:store) { FactoryBot.create(:store) }

  subject {
    if SolidusSupport.solidus_gem_version < Gem::Version.new('2.8.x')
      get "/api/products/#{product.to_param}", headers: {
        'X-Spree-Token' => user.spree_api_key
      }
    else
      get "/api/products/#{product.to_param}", headers: {
        'Authorization' => "Bearer #{user.spree_api_key}"
      }
    end
  }

  describe :show do
    context 'when the product is not added to the store' do
      it 'should return 404' do
        subject
        expect(response.response_code).to eq(404)
      end
    end

    context 'when the product is added to the store' do
      before(:each) { product.stores << store }

      describe 'requesting a wrong store for the product' do
        let!(:store_2) { FactoryBot.create(:store) }

        it 'returns 404' do
          host! store_2.url
          subject
          expect(response.response_code).to eq(404)
        end
      end

      describe 'requesting the right store for the product' do
        it 'returns a successful product with successful code' do
          subject
          expect(response.response_code).to eq(200)
        end
      end
    end
  end
end
