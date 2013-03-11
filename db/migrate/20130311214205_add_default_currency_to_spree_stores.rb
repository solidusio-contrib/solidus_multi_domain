class AddDefaultCurrencyToSpreeStores < ActiveRecord::Migration
  def change
    add_column :spree_stores, :default_currency, :string
  end
end
