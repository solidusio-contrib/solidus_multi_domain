class CreateProductsStores < ActiveRecord::Migration
  def self.up
    create_table :products_stores, :id => false do |t|
      t.references :product
      t.references :store
      t.timestamps null: true
    end
  end

  def self.down
    drop_table :products_stores
  end
end
