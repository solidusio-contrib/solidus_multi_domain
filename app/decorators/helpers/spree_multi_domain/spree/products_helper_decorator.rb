# frozen_string_literal: true

module SpreeMultiDomain
  module Spree
    module ProductsHelperDecorator
      def self.prepended(base)
        base.module_eval do
          def get_taxonomies
            @taxonomies ||= current_store.present? ? ::Spree::Taxonomy.where(["store_id = ?", current_store.id]) : ::Spree::Taxonomy
            @taxonomies = @taxonomies.includes(root: :children)
            @taxonomies
          end
        end
      end

      ::Spree::ProductsHelper.prepend self
    end
  end
end
