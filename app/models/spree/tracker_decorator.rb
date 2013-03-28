Spree::Tracker.class_eval do
  belongs_to :store
  attr_accessible :store_id

  def self.current(domain)
    Spree::Tracker.where(:active => true, :environment => Rails.env).joins(:store).where("spree_stores.domains LIKE ?", "%#{domain}%").first
  end
end
