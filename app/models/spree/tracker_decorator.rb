Spree::Tracker.class_eval do
  belongs_to :store

  def self.current(store)
    Spree::Tracker.where(active: true, store_id: store).first
  end
end
