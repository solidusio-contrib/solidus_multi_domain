require 'spec_helper'

describe Spree::Store do

  before(:each) do
    @store = FactoryGirl.create(:store, :domains => "website1.com\nwww.subdomain.com")
    @store2 = FactoryGirl.create(:store, :domains => 'freethewhales.com')
  end

  it "should find stores by domain" do
    by_domain = Spree::Store.by_domain('www.subdomain.com')

    by_domain.should include(@store)
    by_domain.should_not include(@store2)
  end

end
