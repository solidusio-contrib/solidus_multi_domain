Spree::ProductsController.class_eval do
  before_filter :can_show_product, :only => :show

  private
  def can_show_product
    @product ||= Spree::Product.find_by_permalink!(params[:id])
    if @product.stores.empty? || @product.stores.include?(@site)
      render :file => "#{::Rails.root}/public/404.html", :status => 404
    end
  end

end
