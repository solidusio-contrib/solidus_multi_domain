class StoreIdForTaxonomies < ActiveRecord::Migration
  def self.up
    add_column "taxonomies", "store_id", :integer
    add_index "taxonomies", "store_id"
  end

  def self.down
    remove_column "taxonomies", "store_id"
  end
end