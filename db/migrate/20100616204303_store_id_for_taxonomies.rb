class StoreIdForTaxonomies < SolidusSupport::Migration[5.1]
  def self.up
    if table_exists?('taxonomies')
      add_reference :taxonomies, :store
    elsif table_exists?('spree_taxonomies')
      add_reference :spree_taxonomies, :store
    end
  end

  def self.down
    if table_exists?('taxonomies')
      remove_reference :taxonomies, :store
    elsif table_exists?('spree_taxonomies')
      remove_reference :spree_taxonomies, :store
    end
  end
end
