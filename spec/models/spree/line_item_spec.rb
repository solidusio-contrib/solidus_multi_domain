require 'spec_helper'

describe Spree::LineItem do
  describe "before create" do

    let(:order_store) { create(:store) }
    let(:other_store) { create(:store) }
    let(:order)       { create(:order, store: order_store) }
    let(:variant)     { create(:variant, product: product) }
    let(:line_item)   { build(:line_item, order: order, product: product) }

    subject { line_item.save! }

    context "the order does not have a store" do
      before do
        version = Spree.try(:solidus_gem_version)
        if version && version >= Gem::Version.new("1.3.0.alpha")
          skip "As of 1.3.0 Orders must have a store"
        end
      end

      before(:each) { order.update_attributes(store_id: nil) }
      let(:product) { create(:product, stores: [order_store])}

      it 'does not raise an error' do
        expect{ subject }.to_not raise_error
      end
    end

    context "the line item's product does not belong to the order's store" do
      let(:product) { create(:product, stores: [other_store]) }

      it 'raises the correct error' do
        expect{ subject }.to raise_error(SpreeMultiDomain::ProductDoesNotBelongToStoreError)
      end
    end

    context "the line item's product belongs to the order's store" do
      let(:product) { create(:product, stores: [order_store])}

      it "does not raise an error" do
        expect{ subject }.to_not raise_error
      end
    end
  end
end
