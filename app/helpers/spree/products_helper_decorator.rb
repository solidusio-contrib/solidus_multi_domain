module Spree
  module Api
    ProductsHelper.class_eval do
      def get_taxonomies
        @taxonomies ||= current_store.present? ? Spree::Taxonomy.where(["store_id = ?", current_store.id]) : Spree::Taxonomy
        @taxonomies = @taxonomies.includes(root: :children)
        @taxonomies
      end
    end
  end
end
