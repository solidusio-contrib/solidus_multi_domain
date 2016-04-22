require 'spec_helper'

describe "Template renderer with dynamic layouts" do
  before(:each) do
    ApplicationController.view_paths = [ActionView::FixtureResolver.new(
        "spree/layouts/spree_application.html.erb"             => "Default layout <%= yield %>",
        "spree/layouts/my_store/spree_application.html.erb"    => "Store layout <%= yield %>",
        "application/index.html.erb"                           => "hello"
      )]
  end

  let(:store) { FactoryGirl.create :store, code: "my_store" }

  it "should render the layout corresponding to the current store" do
    get "http://#{store.url}"
    expect(response.body).to eql("Store layout hello")
  end

  it "should fall back to the default layout if none are found for the current store" do
    get "http://www.example.com"
    expect(response.body).to eql("Default layout hello")
  end

  context "for a controller inheriting from ApplicationController" do
    NormalController = Class.new(ApplicationController)

    before do
      ApplicationController.view_paths += [ActionView::FixtureResolver.new(
          "normal/index.html.erb" => "just normal"
        )]
      Rails.application.routes.draw do
        get 'normal', to: 'normal#index'
      end
    end
    it "should fall back to the default layout for unmatched store" do
      get "http://www.example.com/normal"
      expect(response.body).to eq("Default layout just normal")
    end
    it "should render the layout for the current store" do
      get "http://#{store.url}/normal"
      expect(response.body).to eq("Store layout just normal")
    end
  end
end
