# frozen_string_literal: true

module SolidusMultiDomain
  module Orders
    module Index
      class Component < SolidusAdmin::Orders::Index::Component
        def columns
          super + [store_column]
        end

        def store_column
          {
            header: :store,
            data: ->(order) do
              store_name = order.store.name
              content_tag :div, String(store_name)
            end
          }
        end

        def filters
          super + [
            {
              label: t('.filters.promotions'),
              combinator: 'or',
              attribute: promotion_attribute,
              predicate: 'in',
              options: promotion_options
            }
          ]
        end

        private

        def promotion_attribute
          Object.const_defined?('Spree::Promotion') ? 'promotions_id' : 'solidus_promotions_id'
        end

        def promotion_options
          promotion_class.all.pluck(:name, :id)
        end

        def promotion_class
          if Object.const_defined?('Spree::Promotion')
            ::Spree::Promotion
          else
            ::SolidusPromotions::Promotion
          end
        end
      end
    end
  end
end
