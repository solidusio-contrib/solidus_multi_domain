# frozen_string_literal: true

module SolidusMultiDomain
  module MultiDomainHelpers
    extend ActiveSupport::Concern

    included do
      include ::Spree::Core::ControllerHelpers::Store # current_store
      include ::Spree::Core::ControllerHelpers::Common # layout :get_layout
      helper 'spree/products'
      helper 'spree/taxons'

      before_action :add_current_store_id_to_params
      helper_method :current_store
    end

    def get_taxonomies
      @taxonomies ||= if current_store.present?
                        ::Spree::Taxonomy.where(["store_id = ?",
                                                 current_store.id])
                      else
                        ::Spree::Taxonomy
                      end
      @taxonomies = @taxonomies.includes(root: :children)
      @taxonomies
    end

    def add_current_store_id_to_params
      params[:current_store_id] = current_store.try(:id)
    end
  end
end
