require 'spec_helper'

describe Spree::Admin::StoresController do
  
  before do
    controller.stub :current_user => Factory(:admin_user)
  end
  
  describe "on :index" do
    it "renders index" do
      get :index, :use_route => :spree
    end
  end
end
