require 'spec_helper'

describe Spree::Api::ShipmentsController do
  describe '#mine' do
    let!(:user) { create(:user) }
    let!(:store1) { create(:store) }
    let!(:store2) { create(:store) }
    let!(:order_from_store1) { create(:order, store: store1, user: user) }
    let!(:order_from_store2) { create(:order, store: store2, user: user) }

    before(:each) do
      allow(controller).to receive_messages(current_api_user: user)
    end

    it 'should return only shipments from the correct store' do
      create(:shipment, order: order_from_store1)
      create(:shipment, order: order_from_store2)

      allow(controller).to receive_messages(current_store: store1)
      controller.mine

      expect(assigns(:shipments).length).to eq(1)
      expect(assigns(:shipments).first.order.store_id).to eq(store1.id)

      allow(controller).to receive_messages(current_store: store2)
      controller.mine

      expect(assigns(:shipments).length).to eq(1)
      expect(assigns(:shipments).first.order.store_id).to eq(store2.id)
    end
  end

  describe "PUT add" do

    let(:current_api_user) { create(:admin_user) }
    let(:shipment) { create(:shipment) }
    let(:variant) { create(:variant) }

    subject { put :add, params: { variant_id: variant.id, id: shipment.number, quantity: 1 } }

    before(:each) do
      stub_authentication!
    end

    context "A SpreeMultiDomain::LineItemDecorator::ProductDoesNotBelongToStoreError is raised" do
      before(:each) do
        def controller.add
          raise SpreeMultiDomain::LineItemConcerns::ProductDoesNotBelongToStoreError
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
