Factory.define(:store, :class => Spree::Store) do |f|
  f.name 'My store'
  f.code 'my_store'
  f.domains 'www.example.com' # makes life simple, this is the default integration session domain
end
