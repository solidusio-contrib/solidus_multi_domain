require 'spec_helper'

describe Spree::Taxon do    
  describe ".find_by_store_id_and_permalink!" do        
    context "taxon exist in given store" do

      let!(:store) { FactoryGirl.create :store }
      let!(:taxonomy) { FactoryGirl.create :taxonomy , store: store}
      let!(:taxon) { FactoryGirl.create :taxon , taxonomy: taxonomy}      

      let!(:anotherstore) { FactoryGirl.create :store, name: "second-test-store" }
      let!(:anothertaxonomy) { FactoryGirl.create :taxonomy , store: anotherstore}
      let!(:anothertaxon) { FactoryGirl.create :taxon , taxonomy: anothertaxonomy}      

      it "should return a taxon" do
        found_taxon = Spree::Taxon.find_by_store_id_and_permalink!(store.id, taxon.permalink)
        found_taxon.should == taxon
        found_taxon.should_not == anothertaxon
      end        
    end

    context "taxon does not exist in given store" do
      it "should raise active_record::not_found" do
        expect{
          Spree::Taxon.find_by_store_id_and_permalink!(1, "non-existing-permalink")
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end