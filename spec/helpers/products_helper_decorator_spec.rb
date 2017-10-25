require 'spec_helper'

module Spree
  describe ProductsHelper do
    before(:each) do
      @store     = FactoryBot.create(:store)
      @taxonomy  = FactoryBot.create(:taxonomy, :store => @store)
      @taxonomy2 = FactoryBot.create(:taxonomy)

      allow(helper).to receive(:current_store) { @store }
    end

    describe "#get_taxonomies" do
      it "only show taxonomies on current_store" do
        taxonomies = helper.get_taxonomies

        expect(taxonomies).to include(@taxonomy)
        expect(taxonomies).to_not include(@taxonomy2)
      end
    end
  end
end
