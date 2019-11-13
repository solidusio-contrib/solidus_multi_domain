# frozen_string_literal: true

require 'spec_helper'

describe "spree core factories should not raise ProductDoesNotBelongToStoreError" do
  it "is able to build a line_item" do
    expect { build(:line_item) }.not_to raise_error
  end

  it "is able to create a line_item" do
    expect { create(:line_item) }.not_to raise_error
  end

  it "is able to create a line_item with a specified variant" do
    expect { create(:line_item, variant: create(:variant, price: 100.00)) }.not_to raise_error
  end

  it "is able to build an inventory_unit" do
    expect { build(:inventory_unit) }.not_to raise_error
  end

  it "is able to create an inventory_unit" do
    expect { create(:inventory_unit) }.not_to raise_error
  end
end
