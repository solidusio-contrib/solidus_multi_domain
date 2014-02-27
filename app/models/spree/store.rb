module Spree
  class Store < ActiveRecord::Base
    has_and_belongs_to_many :products, :join_table => 'spree_products_stores'
    has_many :taxonomies
    has_many :orders

    has_many :store_payment_methods
    has_many :payment_methods, :through => :store_payment_methods

    has_many :store_shipping_methods
    has_many :shipping_methods, :through => :store_shipping_methods

    has_and_belongs_to_many :promotion_rules, :class_name => 'Spree::Promotion::Rules::Store', :join_table => 'spree_promotion_rules_stores', :association_foreign_key => 'promotion_rule_id'

    validates_presence_of :name, :code, :domains
    
    before_create :ensure_default_exists_and_is_unique

    scope :default, lambda { where(:default => true) }
    scope :by_domain, lambda { |domain| where("domains like ?", "%#{domain}%") }

    has_attached_file :logo,
      :styles => { :mini => '48x48>', :small => '100x100>', :medium => '250x250>' },
      :default_style => :medium,
      :url => 'stores/:id/:style/:basename.:extension',
      :path => 'stores/:id/:style/:basename.:extension',
      :convert_options => { :all => '-strip -auto-orient' }

    def self.current(domain = nil)
      current_store = domain ? Store.by_domain(domain).first : nil
      current_store || first_found_default
    end

    def self.first_found_default
      @cached_default ||= Store.default.first
    end

    def ensure_default_exists_and_is_unique
      if default and not Store.default.empty?
        Store.update_all(default: false)
      elsif Store.default.empty?
        self.default = true
      end
    end
  end
end
