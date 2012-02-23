require 'spec_helper'

describe Spree::Admin::ProductsController do
  
  before do
    controller.stub :current_user => Factory(:admin_user)
  end
  
  describe "on :index" do
    it "renders index" do
      get :index, :use_route => :spree
    end
  end
  
  describe "on a PUT to :update" do
    before(:each) do
      @product = Factory(:product)
      @store = Factory(:store)
    end
  
    describe "when no stores are selected" do
      it "clears stores if they previously existed" do
        @product.stores << @store
        @product.reload
      
        put :update, :id => @product.permalink,
                      :product => {:name => @product.name},
                      :use_route => :spree
                      
        @product.store_ids.should be_empty
      end
    end
    
    describe "when a store is selected" do
      it "clears stores" do
        put :update, :id => @product.permalink,
                      :product => {:name => @product.name, :store_ids => [@store.id]},
                      :use_route => :spree
                      
        @product.reload.store_ids.should == [@store.id]
      end
    end
  end
end
