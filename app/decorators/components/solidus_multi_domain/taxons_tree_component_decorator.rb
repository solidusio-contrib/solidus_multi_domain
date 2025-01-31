# frozen_string_literal: true

module SolidusMultiDomain
  module TaxonsTreeComponentDecorator
    def self.prepended(base)
      base.class_eval do
        private

        def tree(root_taxon:, item_classes:, current_item_classes:, max_level:)
          return if max_level < 1 || root_taxon.children.empty?

          filtered_taxons = root_taxon.children.joins(:taxonomy).where("spree_taxonomies.store_id = ?",
            helpers.current_store.id).distinct

          content_tag :ul do
            taxons = filtered_taxons.map do |taxon|
              classes = item_classes
              if current_item_classes && current_taxon&.self_and_ancestors&.include?(taxon)
                classes = [classes,
                           current_item_classes].join(' ')
              end

              content_tag :li, class: classes do
                link_to(taxon.name, helpers.taxon_seo_url(taxon)) +
                  tree(root_taxon: taxon, item_classes: item_classes, current_item_classes: current_item_classes,
                    max_level: max_level - 1)
              end
            end

            safe_join([taxons], "\n")
          end
        end
      end
    end

    ::TaxonsTreeComponent.prepend self
  end
end
