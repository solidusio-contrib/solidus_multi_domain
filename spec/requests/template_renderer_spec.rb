require 'spec_helper'

describe "Template renderer with dynamic layouts" do
  before(:each) do
    ApplicationController.view_paths = [ActionView::FixtureResolver.new(
        "spree/layouts/spree_application.html.erb"             => "Default layout <%= yield %>",
        "spree/layouts/my_store/spree_application.html.erb"    => "Store layout <%= yield %>",
        "application/index.html.erb"                           => "hello"
      )]
  end

  let(:store) { create :store, code: "my_store" }

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

  context "with an explicit `layout` passed to render" do
    ExplicitLayoutController = Class.new(ApplicationController) do
      def index
        render :index, layout: 'fancy'
      end
    end

    before do
      ApplicationController.view_paths += [ActionView::FixtureResolver.new(
          "layouts/fancy.html.erb"         => "Fancy <%= yield %>",
          "explicit_layout/index.html.erb" => "explicit layout index"
        )]
      Rails.application.routes.draw do
        get 'explicit_layout', to: 'explicit_layout#index'
      end
    end
    it "should use explicit layout for unmatched store" do
      get "http://www.example.com/explicit_layout"
      expect(response.body).to eq("Fancy explicit layout index")
    end
    it "should use explicit layout for the current store" do
      get "http://#{store.url}/explicit_layout"
      expect(response.body).to eq("Fancy explicit layout index")
    end
  end
end
