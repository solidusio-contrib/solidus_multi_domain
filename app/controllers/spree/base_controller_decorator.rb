Spree::BaseController.class_eval do
  helper_method :current_store
  helper_method :current_tracker
  helper :products, :taxons
  before_filter :add_current_store_id_to_params
  private

  def current_store
    @current_store ||= ::Store.current(request.env['SERVER_NAME'])
  end
  
  def current_tracker
    @current_tracker ||= Tracker.current(request.env['SERVER_NAME'])
  end

  def get_taxonomies
    @taxonomies ||= current_store.present? ? Taxonomy.where(["store_id = ?", current_store.id]) : Taxonomy
    @taxonomies = @taxonomies.find(:all, :include => {:root => :children})
    @taxonomies
  end
  
  def add_current_store_id_to_params
    params[:current_store_id] = current_store.try(:id)
  end

end
