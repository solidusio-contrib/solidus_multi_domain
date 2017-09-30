class Namespace < SolidusSupport::Migration[5.1]
  def up
    rename_table :products_stores, :spree_products_stores
  end

  def down
    rename_table :spree_products_stores, :products_stores
  end
end
