class AddSpreePromotionRulesStores < SolidusSupport::Migration[4.2]
  def change
    unless table_exists?('spree_promotion_rules_stores')
      create_table :spree_promotion_rules_stores do |t|
        t.references :store
        t.references :promotion_rule
      end
    end
  end
end
