class AddStoreShippingMethods < ActiveRecord::Migration
  def change
    create_table :spree_store_shipping_methods do |t|
      t.integer :store_id
      t.integer :shipping_method_id

      t.timestamps
    end

    add_index :spree_store_shipping_methods, :store_id
    add_index :spree_store_shipping_methods, :shipping_method_id
  end
end

