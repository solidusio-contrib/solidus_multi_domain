require 'spec_helper'

describe Spree::Store do
  let!(:default_store) { FactoryGirl.create(:store, :default => true, :domains => "default.com") }
  let!(:store_2)       { FactoryGirl.create(:store, :code => 'STORE2', :domains => 'freethewhales.com') }
  let!(:store_3)       { FactoryGirl.create(:store, :code => 'STORE3', :domains => "website1.com\nwww.subdomain.com") }

  it "should find stores by domain" do
    by_domain = Spree::Store.by_domain('www.subdomain.com')

    expect(by_domain).to include(store_3)
    expect(by_domain).not_to include(default_store)
    expect(by_domain).not_to include(store_2)
  end

  it "should find the current store by domain" do
    current_store = Spree::Store.current('website1.com')

    expect(current_store) == store_3
  end

  it "should find the current store by code" do
    current_store = Spree::Store.current('STORE2')

    expect(current_store) == store_2
  end

  describe "default" do
    it "should ensure there is a default if one doesn't exist yet" do
      expect(default_store.default).to be_truthy
    end

    it "should ensure there is only one default" do
      [default_store, store_2, store_3].each(&:reload)

      expect(Spree::Store.default.count) == 1
      expect(default_store.default).to be_truthy
      expect(store_2.default).to be_falsey
      expect(store_3.default).to be_falsey
    end
  end
end
