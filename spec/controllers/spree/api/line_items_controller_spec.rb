require 'spec_helper'

describe Spree::Api::LineItemsController do

  before(:each) do
    stub_authentication!
  end

  describe "POST create" do
    let(:user) { create(:user) }
    let(:current_api_user) { user }
    let(:order) { create(:order, user: user) }
    let(:line_item) { build(:line_item, order: order) }

    subject { spree_post :create, line_item: line_item, order_id: line_item.order.number }

    context "A SpreeMultiDomain::LineItemDecorator::ProductDoesNotBelongToStoreError is raised" do
      before(:each) do
        def controller.create
          raise SpreeMultiDomain::LineItemDecorator::ProductDoesNotBelongToStoreError
        end
      end

      it "sets the correct status" do
        subject
        expect(response.status).to eq 422
      end

      it "contains the correct error message" do
        subject
        expect(JSON.parse(response.body)["message"]).to eq "Products from different stores may not be added to this order."
      end
    end
  end
end
