Spree::Tracker.class_eval do
  belongs_to :store

  def self.current(store_key)
    Spree::Tracker.where(active: true).joins(:store).where("spree_stores.code = ? OR spree_stores.url LIKE ?", store_key, "%#{store_key}%").first
  end
end
