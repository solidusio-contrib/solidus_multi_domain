class AddEmailToStores < ActiveRecord::Migration
  def self.up    
    change_table :stores do |t|
      t.string :email
    end
  end

  def self.down
    change_table :stores do |t|
      t.remove :email
    end
  end
end
