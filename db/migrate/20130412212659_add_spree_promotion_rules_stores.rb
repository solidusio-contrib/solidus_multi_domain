class AddSpreePromotionRulesStores < SolidusSupport::Migration[4.2]
  def change
    create_table :spree_promotion_rules_stores, :id => false do |t|
      t.references :promotion_rule
      t.references :store
    end
  end
end
