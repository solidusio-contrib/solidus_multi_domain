# frozen_string_literal: true

class RemoveDatetimeColumnsFromProductsStores < SolidusSupport::Migration[4.2]
  def self.up
    change_table :products_stores do |t|
      t.remove :created_at, :updated_at
    end
  end

  def self.down
    change_table :products_stores, &:timestamps
  end
end
