class AddStoreShippingMethods < SolidusSupport::Migration[4.2]
  def change
    return if table_exists?(:spree_store_shipping_methods)

    create_table :spree_store_shipping_methods do |t|
      t.integer :store_id
      t.integer :shipping_method_id

      t.timestamps null: true
    end

    add_index :spree_store_shipping_methods, :store_id
    add_index :spree_store_shipping_methods, :shipping_method_id
  end
end

