FactoryGirl.modify do
  # Products need to belong to the same store as the order.
  factory :line_item do
    before(:create) do |line_item, evaluator|
      if line_item.order.store
        line_item.product.stores << line_item.order.store
      end
    end
  end
end
