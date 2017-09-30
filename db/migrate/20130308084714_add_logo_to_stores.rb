class AddLogoToStores < SolidusSupport::Migration[5.1]
  def self.up
    change_table :spree_stores do |t|
      t.string :logo_file_name
    end
  end

  def self.down
    change_table :spree_stores do |t|
      t.remove :logo_file_name
    end
  end
end
