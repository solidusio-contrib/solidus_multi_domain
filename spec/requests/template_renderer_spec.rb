require 'spec_helper'

describe "Template renderer with dynamic layouts" do
  before(:each) do
    ApplicationController.view_paths = [ActionView::FixtureResolver.new(
        "spree/layouts/spree_application.html.erb"             => "Default layout <%= yield %>",
        "spree/layouts/my_store/spree_application.html.erb"    => "Store layout <%= yield %>",
        "application/index.html.erb"                           => "hello"
      )]
  end

  it "should render the layout corresponding to the current store" do
    FactoryGirl.create :store

    get "http://www.example.com"
    response.body.should eql("Store layout hello")
  end

  it "should fall back to the default layout if none are found for the current store" do
    ApplicationController.stub(:current_store).and_return(nil)

    get "http://www.example.com"
    response.body.should eql("Store layout hello")
  end
end
