# frozen_string_literal: true

require 'spec_helper'

describe Spree::Store do
  let!(:default_store) { FactoryBot.create(:store, default: true, url: "default.com") }
  let!(:store_2)       { FactoryBot.create(:store, code: 'STORE2', url: 'freethewhales.com') }
  let!(:store_3)       { FactoryBot.create(:store, code: 'STORE3', url: "website1.com\nwww.subdomain.com") }

  describe "default" do
    it "ensures there is a default if one doesn't exist yet" do
      expect(default_store.default).to be_truthy
    end

    it "ensures there is only one default" do
      [default_store, store_2, store_3].each(&:reload)

      expect(described_class.default).to eq default_store
      expect(default_store.default).to be_truthy
      expect(store_2.default).to be_falsey
      expect(store_3.default).to be_falsey
    end
  end
end
