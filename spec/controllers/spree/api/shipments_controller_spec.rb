# frozen_string_literal: true

require 'solidus_multi_domain_spec_helper'

RSpec.describe Spree::Api::ShipmentsController do
  routes { Spree::Core::Engine.routes }
  describe '#mine' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:store1) { FactoryBot.create(:store) }
    let!(:store2) { FactoryBot.create(:store) }
    let!(:order_from_store1) { FactoryBot.create(:order, store: store1, user: user) }
    let!(:order_from_store2) { FactoryBot.create(:order, store: store2, user: user) }

    before do
      allow(controller).to receive_messages(current_api_user: user)
    end

    it 'returns only shipments from the correct store' do
      FactoryBot.create(:shipment, order: order_from_store1)
      FactoryBot.create(:shipment, order: order_from_store2)

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
    subject { put :add, params: { variant_id: variant.id, id: shipment.number, quantity: 1 } }

    let(:current_api_user) { create(:admin_user) }
    let(:shipment) { create(:shipment) }
    let(:variant) { create(:variant) }

    before do
      stub_authentication!
    end

    context "A SolidusMultiDomain::LineItemDecorator::ProductDoesNotBelongToStoreError is raised" do
      before do
        def controller.add
          raise SolidusMultiDomain::ProductDoesNotBelongToStoreError
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
