require 'spec_helper'

describe Spree::Admin::OrdersController do
  stub_authorization!

  let!(:store) { FactoryGirl.create(:store) }
  let!(:alt_store) { FactoryGirl.create(:store) }

  let!(:order) { FactoryGirl.create(:shipped_order, store: store) }
  let!(:another_order) { FactoryGirl.create(:shipped_order, store: alt_store) }

  let(:params) do
    {}
  end

  describe 'on :index' do
    before do
      allow(controller).to receive_messages(current_store: store)
      spree_get :index, params
    end

    it 'only shows orders for current_store' do
      spree_get :index
      expect_only_one_order
    end

    context 'when filtering' do
      let(:params) do
        { q: { line_items_variant_id_in: Spree::Variant.all.map(&:id) } }
      end

      it 'only shows orders for current_store' do
        expect_only_one_order
      end
    end
  end

  def expect_only_one_order
    order_numbers = assigns[:orders].map(&:number)

    expect(order_numbers).to include(order.number)
    expect(order_numbers).to_not include(another_order.number)
  end
end
