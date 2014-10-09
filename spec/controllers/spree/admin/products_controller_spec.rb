require 'spec_helper'

describe Spree::Admin::ProductsController do
  stub_authorization!

  describe "on :index" do
    it "renders index" do
      spree_get :index
      response.should be_success
    end
  end

  describe "on a PUT to :update" do
    before(:each) do
      @product = FactoryGirl.create(:product)
      @store = FactoryGirl.create(:store)
    end

    describe "when no stores are selected" do
      it "clears stores if they previously existed" do
        @product.stores << @store

        spree_put :update, :id => @product.to_param,
                      :product => {:name => @product.name}, update_store_ids: 'true'

        @product.reload.store_ids.should be_empty
      end
    end

    describe "when a store is selected" do
      it "clears stores" do
        spree_put :update, :id => @product.to_param,
                      :product => {:name => @product.name, :store_ids => [@store.id]}, update_store_ids: 'true'

        @product.reload.store_ids.should == [@store.id]
      end
    end

    describe "when not updating stores" do
      it "does not touch existing stores" do
        @product.stores << @store

        spree_put :update, :id => @product.to_param, :product => {:name => "Test"}

        @product.reload.store_ids.should == [@store.id]
      end
    end
  end
end
