FactoryGirl.define do
  factory :store, :class => Spree::Store do
    name 'My store'
    code 'my_store'
    domains 'www.example.com' # makes life simple, this is the default
    # integration session domain
  end
end
