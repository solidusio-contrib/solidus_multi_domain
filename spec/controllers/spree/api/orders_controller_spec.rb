require 'spec_helper'

describe Spree::Api::OrdersController do
  describe '#mine' do
    let!(:user) { create(:user) }
    let!(:store1) { create(:store) }
    let!(:store2) { create(:store) }
    let!(:order_from_store1) { create(:order, store: store1, user: user) }
    let!(:order_from_store2) { create(:order, store: store2, user: user) }

    before(:each) do
      allow(controller).to receive_messages(current_api_user: user)
    end

    it 'returns only orders from the correct store' do
      allow(controller).to receive_messages(current_store: store1)
      controller.mine

      expect(assigns(:orders).length).to eq(1)
      expect(assigns(:orders).first.store_id).to eq(store1.id)

      allow(controller).to receive_messages(current_store: store2)
      controller.mine

      expect(assigns(:orders).length).to eq(1)
      expect(assigns(:orders).first.store_id).to eq(store2.id)
    end
  end
end
