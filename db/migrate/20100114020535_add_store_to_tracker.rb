class AddStoreToTracker < ActiveRecord::Migration
  def self.up    
    change_table :trackers do |t|
      t.references :store
    end
  end

  def self.down
    change_table :trackers do |t|
      t.remove :store_id
    end
  end
end