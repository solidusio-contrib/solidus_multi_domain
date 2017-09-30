class RemoveDatetimeColumnsFromProductsStores < SolidusSupport::Migration[5.1]
  def self.up
    change_table :products_stores do |t|
      t.remove :created_at, :updated_at
    end
  end

  def self.down
    change_table :products_stores do |t|
      t.timestamps
    end
  end
end
