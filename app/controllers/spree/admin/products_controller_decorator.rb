Spree::Admin::ProductsController.class_eval do
  update.before :set_stores

  private
  def set_stores
    # Remove all store associations if store data is being passed and no stores are selected
    if params[:update_store_ids] && !params[:product].key?(:store_ids)
      @product.stores.clear
    end
  end

end
