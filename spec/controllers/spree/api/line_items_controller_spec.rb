# frozen_string_literal: true

require 'spec_helper'

describe Spree::Api::LineItemsController do
  before do
    stub_authentication!
  end

  describe "POST create" do
    subject { post :create, params: { line_item: line_item, order_id: line_item.order.number } }

    let(:user) { create(:user) }
    let(:current_api_user) { user }
    let(:order) { create(:order, user: user) }
    let(:line_item) { build(:line_item, order: order) }

    context "A SpreeMultiDomain::LineItemDecorator::ProductDoesNotBelongToStoreError is raised" do
      before do
        def controller.create
          raise SpreeMultiDomain::ProductDoesNotBelongToStoreError
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
