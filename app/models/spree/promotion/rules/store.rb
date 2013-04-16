module Spree
  class Promotion
    module Rules
      class Store < PromotionRule
        attr_accessible :store_ids_string

        has_and_belongs_to_many :stores, :class_name => 'Spree::Store', :join_table => 'spree_promotion_rules_stores', :foreign_key => 'promotion_rule_id'

        def eligible?(order, options = {})
          stores.none? or stores.include?(order.store)
        end

        def store_ids_string
          store_ids.join(',')
        end

        def store_ids_string=(s)
          self.store_ids = s.to_s.split(',').map(&:strip)
        end

      end
    end
  end
end
