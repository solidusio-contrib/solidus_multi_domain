class AddStoreShippingMethods < SolidusSupport::Migration[5.1]
  def change
    create_table :spree_store_shipping_methods do |t|
      t.references :store
      t.references :shipping_method

      t.timestamps null: true
    end
  end
end
