# frozen_string_literal: true

Spree::Taxonomy.class_eval do
  belongs_to :store
end
