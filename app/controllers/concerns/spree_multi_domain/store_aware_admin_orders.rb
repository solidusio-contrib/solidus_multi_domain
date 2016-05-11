module SpreeMultiDomain::StoreAwareAdminOrders
  extend ActiveSupport::Concern

  included do
    before_filter :merge_store_id_query, only: :index
  end

  private

  def merge_store_id_query
    store_id_hash = { store_id_eq: current_store.id }

    if params[:q].present?
      params[:q].merge!(store_id_hash)
    else
      params[:q] = store_id_hash
    end
  end
end
