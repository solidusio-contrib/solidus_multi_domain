require 'spec_helper'

describe Spree::Store do

  describe "by_domain" do
    let!(:store)    { FactoryGirl.create(:store, :domains => "website1.com\nwww.subdomain.com") }
    let!(:store_2)  { FactoryGirl.create(:store, :domains => 'freethewhales.com') }

    it "should find stores by domain" do
      by_domain = Spree::Store.by_domain('www.subdomain.com')

      expect(by_domain).to include(store)
      expect(by_domain).not_to include(store_2)
    end
  end

  describe "default" do
    let!(:store)    { FactoryGirl.create(:store) }
    let!(:store_2)  { FactoryGirl.create(:store, default: true) }

    it "should ensure there is a default if one doesn't exist yet" do
      expect(store.default).to be_truthy
    end

    it "should ensure there is only one default" do
      [store, store_2].each(&:reload)

      expect(Spree::Store.default.count) == 1
      expect(store_2.default).to be_truthy
      expect(store.default).not_to be_truthy
    end
  end
end
