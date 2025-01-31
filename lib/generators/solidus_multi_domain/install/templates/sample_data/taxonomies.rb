# frozen_string_literal: true

taxonomies = [
  { name: "Categories", store: Spree::Store.first! },
  { name: "Brands",  store: Spree::Store.first! }
]

taxonomies.each do |taxonomy_attrs|
  Spree::Taxonomy.create!(taxonomy_attrs)
end
