# TODO: Remove this and the previous AddStorePaymentMethods migration in a
# future release.
class RemoveStorePaymentMethods < ActiveRecord::Migration
  def up
    # Be careful in case someone was actually using this table
    if ActiveRecord::Base.connection.table_exists?('spree_store_payment_methods')
      row_count = Integer(ActiveRecord::Base.connection.select_value("select count(0) from spree_store_payment_methods limit 1"))
      if row_count > 0
        raise "You have #{row_count} rows in spree_store_payment_methods. Please ensure you don't need the functionality this table used to provide and then delete the rows and re-run this migration."
      end
    end

    drop_table :spree_store_payment_methods
  end

  def down
    create_table :spree_store_payment_methods do |t|
      t.integer :store_id
      t.integer :payment_method_id

      t.timestamps null: true
    end
  end
end
