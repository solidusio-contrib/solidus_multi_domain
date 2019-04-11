require 'spec_helper'

describe Spree::ShippingMethod do
  let(:shipping_method) { create :shipping_method }
  let(:order) { create :order, :store => store }
  let(:store) { create :store }

  describe '.store_match?' do
    subject { shipping_method.store_match?(order) }

    context 'when store contains this shipping method' do
      before { store.shipping_methods << shipping_method }
      it { is_expected.to eq(true) }
    end

    context "when the store does not contain this shipping method" do
      context "when the store has no shipping methods" do
        it { is_expected.to eq(true) }
      end

      context "when the store has at least on shipping method" do
        before { store.shipping_methods << create(:shipping_method) }
        it { is_expected.to eq(false)}
      end
    end
  end
end
