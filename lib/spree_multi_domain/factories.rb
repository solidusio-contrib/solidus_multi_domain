FactoryGirl.define do
  factory :store, :class => Spree::Store do
    name 'My store'
    code 'my_store'
    domains 'www.example.com' # makes life simple, this is the default
    # integration session domain
  end

  factory :taxonomy, :class=>Spree::Taxonomy do
    name "TestTaxonmy"
    store
  end

  factory :taxon, :class=>Spree::Taxon do
    name "mytaxon"
    taxonomy
  end
end
