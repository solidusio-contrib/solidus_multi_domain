# frozen_string_literal: true

module SolidusMultiDomain
  module Spree
    module TaxonomyDecorator
      def self.prepended(base)
        base.class_eval do
          belongs_to :store
        end
      end

      ::Spree::Taxonomy.prepend self
    end
  end
end
