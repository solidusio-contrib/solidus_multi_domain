Spree::Tracker.class_eval do
  belongs_to :store

  def self.current(store)
    if store.is_a?(Spree::Store)
      Spree::Tracker.where(active: true, store_id: store).first
    else
      # TODO: Remove in 2.0
      ActiveSupport::Deprecation.warn <<-EOS.squish, caller
        Calling Spree::Tracker.current with a string is DEPRECATED. Instead
        pass it an instance of Spree::Store.
      EOS
      Spree::Tracker.where(active: true).joins(:store).where(
        "spree_stores.code = ? OR spree_stores.url LIKE ?",
        store, "%#{store}%"
      ).first
    end
  end
end
