# frozen_string_literal: true

module TaxonDecorator
  extend ActiveSupport::Concern

  included do
    def self.find_by_store_id_and_permalink!(store_id, permalink)
      joins(:taxonomy).where("spree_taxonomies.store_id = ?", store_id).where(permalink: permalink).first!
    end
  end
end

Spree::Taxon.include(TaxonDecorator)
