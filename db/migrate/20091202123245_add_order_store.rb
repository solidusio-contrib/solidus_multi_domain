class AddOrderStore < SolidusSupport::Migration[5.1]
  def self.up
    if table_exists?('orders')
      add_reference :orders, :store
    elsif table_exists?('spree_orders')
      add_reference :spree_orders, :store unless column_exists?(:spree_orders, :store_id)
    end
  end

  def self.down
    if table_exists?('orders')
      remove_reference :orders, :store
    elsif table_exists?('spree_orders')
      remove_reference :spree_orders, :store
    end
  end
end
