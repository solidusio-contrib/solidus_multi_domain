FactoryGirl.define do
  factory :store, :class => Spree::Store do
    name 'My store'
    code 'my_store'
    domains 'www.example.com' # makes life simple, this is the default
    # integration session domain
  end
end

FactoryGirl.modify do
  # line item products need to belong to the same store as the order to be valid
  factory :line_item do
    before(:create) do |line_item, evaluator|
      if line_item.order.store
        line_item.product.stores << line_item.order.store
      end
    end
  end
end
