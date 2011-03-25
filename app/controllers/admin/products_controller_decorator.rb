Admin::ProductsController.class_eval do
  update.before :set_stores

  create.before :add_to_all_stores

  private
  def set_stores
    @product.store_ids = nil unless params[:product].key? :store_ids
  end

  def add_to_all_stores
  end
end
