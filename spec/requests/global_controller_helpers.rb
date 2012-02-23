require 'spec_helper'

describe "Global controller helpers" do

  before(:each) do
    @store = Factory :store
    @tracker = Factory :tracker, :store => @store
    get '/'
  end
  
  it "should include the right tracker" do
    response.body.should include(@tracker.analytics_id)
  end
  
  it "should populate the params with store id" do
    request.params[:current_store_id].should == @store.id
  end
  
  it "should create a store-aware order" do
    controller.current_store.should == @store
  end
  
  it "should instantiate the correct store-bound tracker" do
    controller.current_tracker.should == @tracker
  end
  
end
