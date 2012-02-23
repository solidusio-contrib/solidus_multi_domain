class AddDefaultStore < ActiveRecord::Migration
  def self.up
    add_column :stores, :default, :boolean, :default => false
  end

  def self.down
    remove_column :stores, :default
  end
end
