FactoryGirl.modify do
  # Products need to belong to the same store as the order.
  factory :user do
    trait :api do
      spree_api_key FFaker::Random.seed
    end
  end

  factory :line_item do
    after(:build) do |line_item, evaluator|
      if line_item.order.store && line_item.product.stores.empty?
        line_item.product.stores << line_item.order.store
      end
    end
  end
end
