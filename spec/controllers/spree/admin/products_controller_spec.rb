# frozen_string_literal: true

require 'spec_helper'

describe Spree::Admin::ProductsController do
  stub_authorization!

  describe "on :index" do
    it "renders index" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "on a PUT to :update" do
    before do
      @product = FactoryBot.create(:product)
      @store = FactoryBot.create(:store)
    end

    describe "when no stores are selected" do
      it "clears stores if they previously existed" do
        @product.stores << @store

        put :update,
          params: {
            id: @product.to_param,
            product: { name: @product.name },
            update_store_ids: 'true'
          }

        expect(@product.reload.store_ids).to be_empty
      end
    end

    describe "when a store is selected" do
      it "clears stores" do
        put :update,
          params: {
            id: @product.to_param,
            product: { name: @product.name, store_ids: [@store.id] },
            update_store_ids: 'true'
          }

        expect(@product.reload.store_ids).to eq [@store.id]
      end
    end
  end
end
