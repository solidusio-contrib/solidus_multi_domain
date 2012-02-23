class AddOrderStore < ActiveRecord::Migration
  def self.up
    if table_exists?('orders')
      add_column :orders, :store_id, :integer
    elsif table_exists?('spree_orders')
      add_column :spree_orders, :store_id, :integer
    end
  end

  def self.down
    if table_exists?('orders')
      remove_column :orders, :store_id
    elsif table_exists?('spree_orders')
      remove_column :spree_orders, :store_id
    end
  end
end
