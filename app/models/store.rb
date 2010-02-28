class Store < ActiveRecord::Base
  has_and_belongs_to_many :products
  has_many :taxonomies
  has_many :orders

  validates_presence_of :name, :code, :domains

  named_scope :default, :conditions => {:default => true}
  named_scope :by_domain, lambda { |domain| { :conditions => ["domains like ?", "%#{domain}%"] } }
end
