class AddOrderStore < ActiveRecord::Migration
  def self.up
    add_column :orders, :store_id, :integer
  end

  def self.down
    remove_column :orders, :store_id
  end
end