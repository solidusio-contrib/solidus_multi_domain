# frozen_string_literal: true

require 'spec_helper'

describe "Template renderer with dynamic layouts" do
  before do
    @old_view_paths = ApplicationController.view_paths

    ApplicationController.view_paths = [ActionView::FixtureResolver.new(
      "spree/layouts/spree_application.html.erb" => "Default layout <%= yield %>",
      "spree/layouts/my_store/spree_application.html.erb" => "Store layout <%= yield %>",
      "application/index.html.erb" => "hello"
    )]
  end

  after do
    ApplicationController.view_paths = @old_view_paths
  end

  let(:store) { FactoryBot.create :store, code: "my_store" }

  it "renders the layout corresponding to the current store" do
    get "http://#{store.url}"
    expect(response.body).to eql("Store layout hello")
  end

  it "falls back to the default layout if none are found for the current store" do
    get "http://www.example.com"
    expect(response.body).to eql("Default layout hello")
  end

  context "for a controller inheriting from ApplicationController" do
    before(:all) do
      NormalController = Class.new(ApplicationController)
    end

    before do
      ApplicationController.view_paths += [ActionView::FixtureResolver.new(
        "normal/index.html.erb" => "just normal"
      )]

      Rails.application.routes.draw do
        get 'normal', to: 'normal#index' # rubocop:disable Rails/HttpPositionalArguments
      end
    end

    after do
      Rails.application.reload_routes!
    end

    it "falls back to the default layout for unmatched store" do
      get "http://www.example.com/normal"
      expect(response.body).to eq("Default layout just normal")
    end

    it "renders the layout for the current store" do
      get "http://#{store.url}/normal"
      expect(response.body).to eq("Store layout just normal")
    end
  end

  context "with an explicit `layout` passed to render" do
    before(:all) do
      ExplicitLayoutController = Class.new(ApplicationController) do
        def index
          render :index, layout: 'fancy'
        end
      end
    end

    before do
      ApplicationController.view_paths += [ActionView::FixtureResolver.new(
        "layouts/fancy.html.erb" => "Fancy <%= yield %>",
        "explicit_layout/index.html.erb" => "explicit layout index"
      )]

      Rails.application.routes.draw do
        # rubocop:disable Rails/HttpPositionalArguments
        get 'explicit_layout', to: 'explicit_layout#index'
        # rubocop:enable Rails/HttpPositionalArguments
      end
    end

    after do
      Rails.application.reload_routes!
    end

    it "uses explicit layout for unmatched store" do
      get "http://www.example.com/explicit_layout"
      expect(response.body).to eq("Fancy explicit layout index")
    end

    it "uses explicit layout for the current store" do
      get "http://#{store.url}/explicit_layout"
      expect(response.body).to eq("Fancy explicit layout index")
    end
  end
end
