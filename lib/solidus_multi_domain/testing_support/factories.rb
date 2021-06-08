# frozen_string_literal: true
FactoryBot.use_parent_strategy = false

FactoryBot.modify do
  # Products need to belong to the same store as the order.
  factory :line_item do
    after(:build) do |line_item, _evaluator|
      if line_item.order.store && line_item.product.stores.empty?
        line_item.product.stores << line_item.order.store
      end
    end
  end
end
