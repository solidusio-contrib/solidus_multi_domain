# frozen_string_literal: true

require 'solidus_multi_domain_spec_helper'

RSpec.describe Spree::Taxon do
  describe ".find_by_store_id_and_permalink!" do
    context "taxon exist in given store" do
      let!(:store) { FactoryBot.create :store }
      let!(:taxonomy) { FactoryBot.create :taxonomy, store: store }
      let!(:taxon) { FactoryBot.create :taxon, taxonomy: taxonomy }

      let!(:anotherstore) { FactoryBot.create :store, name: "second-test-store" }
      let!(:anothertaxonomy) { FactoryBot.create :taxonomy, store: anotherstore }
      let!(:anothertaxon) { FactoryBot.create :taxon, taxonomy: anothertaxonomy }

      it "returns a taxon" do
        # rubocop:disable Rails/DynamicFindBy
        found_taxon = described_class.find_by_store_id_and_permalink!(store.id, taxon.permalink)
        # rubocop:enable Rails/DynamicFindBy
        expect(found_taxon).to eq taxon
        expect(found_taxon).not_to eq anothertaxon
      end
    end

    context "taxon does not exist in given store" do
      it "raise active_record::not_found" do
        expect{
          # rubocop:disable Rails/DynamicFindBy
          described_class.find_by_store_id_and_permalink!(1, "non-existing-permalink")
          # rubocop:enable Rails/DynamicFindBy
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
