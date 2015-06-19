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
    store = FactoryGirl.create :store, code: "my_store"

    get "http://#{store.url}"
    expect(response.body).to eql("Store layout hello")
  end

  it "should fall back to the default layout if none are found for the current store" do
    allow(ApplicationController).to receive(:current_store).and_return(nil)

    get "http://www.example.com"
    expect(response.body).to eql("Default layout hello")
  end
end
