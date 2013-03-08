module Spree
  class Store < ActiveRecord::Base
    include Spree::Core::S3Support
    has_and_belongs_to_many :products, :join_table => 'spree_products_stores'
    has_many :taxonomies
    has_many :orders

    validates_presence_of :name, :code, :domains
    attr_accessible :name, :code, :default, :email, :domains, :logo

    scope :default, where(:default => true)
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
  end
end
