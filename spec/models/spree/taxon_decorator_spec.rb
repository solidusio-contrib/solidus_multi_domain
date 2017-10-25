require 'spec_helper'

describe Spree::Taxon do
  describe ".find_by_store_id_and_permalink!" do
    context "taxon exist in given store" do

      let!(:store) { FactoryBot.create :store }
      let!(:taxonomy) { FactoryBot.create :taxonomy , store: store}
      let!(:taxon) { FactoryBot.create :taxon , taxonomy: taxonomy}

      let!(:anotherstore) { FactoryBot.create :store, name: "second-test-store" }
      let!(:anothertaxonomy) { FactoryBot.create :taxonomy , store: anotherstore}
      let!(:anothertaxon) { FactoryBot.create :taxon , taxonomy: anothertaxonomy}

      it "returns a taxon" do
        found_taxon = Spree::Taxon.find_by_store_id_and_permalink!(store.id, taxon.permalink)
        expect(found_taxon).to eq taxon
        expect(found_taxon).to_not eq anothertaxon
      end
    end

    context "taxon does not exist in given store" do
      it "raise active_record::not_found" do
        expect{
          Spree::Taxon.find_by_store_id_and_permalink!(1, "non-existing-permalink")
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
