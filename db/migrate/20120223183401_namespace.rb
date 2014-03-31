class Namespace < ActiveRecord::Migration
  def up
    rename_table :products_stores, :spree_products_stores
  end

  def down
    rename_table :spree_products_stores, :products_stores
  end
end
