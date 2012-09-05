Spree::Taxonomy.class_eval do
  belongs_to :store
  attr_accessible :store_id
end
