class AddStoreToTracker < ActiveRecord::Migration
  def self.up
    if table_exists?('trackers')
      change_table :trackers do |t|
        t.references :store
      end
    elsif table_exists?('spree_trackers')
      change_table :spree_trackers do |t|
        t.references :store
      end
    end 
  end

  def self.down
    if table_exists?('trackers')
      change_table :trackers do |t|
        t.remove :store_id
      end
    elsif table_exists?('spree_trackers')
      change_table :spree_trackers do |t|
        t.remove :store_id
      end
    end
  end
end
