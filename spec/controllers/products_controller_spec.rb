# frozen_string_literal: true

require 'solidus_multi_domain_spec_helper'

RSpec.describe ::ProductsController do
  let!(:product) { FactoryBot.create(:product) }

  describe 'on :show to a product without any stores' do
    let!(:store) { FactoryBot.create(:store) }

    it 'returns 404' do
      if Spree.solidus_gem_version < Gem::Version.new('2.5.x')
        get :show, params: { id: product.to_param }
        expect(response.response_code).to eq 404
      else
        expect {
          get :show, params: { id: product.to_param }
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  # Regression test for #75
  describe 'on :show to a product in the wrong store' do
    let!(:store_1) { FactoryBot.create(:store) }
    let!(:store_2) { FactoryBot.create(:store) }

    before do
      product.stores << store_1
    end

    it 'returns 404' do
      allow(controller).to receive_messages(current_store: store_2)

      if Spree.solidus_gem_version < Gem::Version.new('2.5.x')
        get :show, params: { id: product.to_param }
        expect(response.response_code).to eq 404
      else
        expect {
          get :show, params: { id: product.to_param }
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'on :show to a product w/ store' do
    let!(:store) { FactoryBot.create(:store) }

    before do
      product.stores << store
    end

    it 'returns 200' do
      allow(controller).to receive_messages(current_store: store)
      get :show, params: { id: product.to_param }

      expect(response.response_code).to eq 200
    end
  end
end
