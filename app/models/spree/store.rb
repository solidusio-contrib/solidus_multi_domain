module Spree
  class Store < ActiveRecord::Base
    has_and_belongs_to_many :products, :join_table => 'spree_products_stores'
    has_many :taxonomies
    has_many :orders

    validates_presence_of :name, :code, :domains
    attr_accessible :name, :code, :default, :email, :domains

    scope :default, where(:default => true)
    scope :by_domain, lambda { |domain| where("domains like ?", "%#{domain}%") }

    def self.current(domain = nil)
      current_store = domain ? Store.by_domain(domain).first : nil
      current_store || first_found_default
    end

    def self.first_found_default
      @cached_default ||= Store.default.first
    end
  end
end
