class AddStorePaymentMethods < ActiveRecord::Migration
  def change
    create_table :spree_store_payment_methods do |t|
      t.integer :store_id
      t.integer :payment_method_id

      t.timestamps null: true
    end
  end
end
