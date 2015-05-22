require 'spec_helper'

describe Spree::Api::OrdersController do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:store1) { FactoryGirl.create(:store) }
  let!(:store2) { FactoryGirl.create(:store) }

  before(:each) do
    controller.stub(current_api_user: user)
  end

  describe '#mine' do
    it 'should return only orders from the correct store' do
      FactoryGirl.create(:order, store: store1, user: user)
      FactoryGirl.create(:order, store: store2, user: user)

      controller.stub(current_store: store1)
      controller.mine

      expect(assigns(:orders).length).to eq(1)
      expect(assigns(:orders).first.store_id).to eq(store1.id)

      controller.stub(current_store: store2)
      controller.mine

      expect(assigns(:orders).length).to eq(1)
      expect(assigns(:orders).first.store_id).to eq(store2.id)
    end
  end

  describe '#find_current_order' do

    it 'should return the latest incomplete order from the correct store' do
      order1 = FactoryGirl.create(:order, store: store1, state: :cart, user: user)
      order2 = FactoryGirl.create(:order, store: store2, state: :cart, user: user)

      controller.stub(current_store: store1)
      expect(controller.send(:find_current_order)).to eql(order1)

      controller.stub(current_store: store2)
      expect(controller.send(:find_current_order)).to eql(order2)
    end
  end
end
