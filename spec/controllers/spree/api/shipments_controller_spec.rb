require 'spec_helper'

describe Spree::Api::ShipmentsController do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:store1) { FactoryGirl.create(:store) }
  let!(:store2) { FactoryGirl.create(:store) }
  let!(:order_from_store1) { FactoryGirl.create(:order, store: store1, user: user) }
  let!(:order_from_store2) { FactoryGirl.create(:order, store: store2, user: user) }

  before(:each) do
    controller.stub(current_api_user: user)
  end

  describe '#mine' do
    it 'should return only shipments from the correct store' do
      FactoryGirl.create(:shipment, order: order_from_store1)
      FactoryGirl.create(:shipment, order: order_from_store2)

      controller.stub(current_store: store1)
      controller.mine

      expect(assigns(:shipments).length).to eq(1)
      expect(assigns(:shipments).first.order.store_id).to eq(store1.id)

      controller.stub(current_store: store2)
      controller.mine

      expect(assigns(:shipments).length).to eq(1)
      expect(assigns(:shipments).first.order.store_id).to eq(store2.id)
    end
  end
end
