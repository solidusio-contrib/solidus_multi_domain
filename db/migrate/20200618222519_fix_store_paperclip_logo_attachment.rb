class FixStorePaperclipLogoAttachment < ActiveRecord::Migration[6.0]
  def change
    remove_column :spree_stores, :logo_file_name, :string
    change_table :spree_stores do |t|
      t.attachment :logo
    end
  end
end
