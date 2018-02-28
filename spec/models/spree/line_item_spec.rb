require 'spec_helper'

describe Spree::LineItem do
  describe "before create" do

    let(:order_store) { create(:store) }
    let(:other_store) { create(:store) }
    let(:order)       { create(:order, store: order_store) }
    let(:variant)     { create(:variant, product: product) }
    let(:line_item)   { build(:line_item, order: order, product: product) }

    subject { line_item.save! }

    context "the line item's product does not belong to the order's store" do
      let(:product) { create(:product, stores: [other_store]) }

      it 'raises the correct error' do
        expect{ subject }.to raise_error(SpreeMultiDomain::LineItemConcerns::ProductDoesNotBelongToStoreError)
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
