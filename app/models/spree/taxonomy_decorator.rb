module TaxonomyDecorator
  extend ActiveSupport::Concern

  included do
    belongs_to :store
  end
end

Spree::Taxonomy.include(TaxonomyDecorator)
