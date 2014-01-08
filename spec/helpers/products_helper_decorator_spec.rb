require 'spec_helper'

module Spree
  describe ProductsHelper do
    before(:each) do
      @store     = FactoryGirl.create(:store)
      @taxonomy  = FactoryGirl.create(:taxonomy, :store => @store)
      @taxonomy2 = FactoryGirl.create(:taxonomy)

      helper.stub(:current_store) { @store }
    end

    describe "#get_taxonomies" do
      it "only show taxonomies on current_store" do
        taxonomies = helper.get_taxonomies

        taxonomies.should include(@taxonomy)
        taxonomies.should_not include(@taxonomy2)
      end
    end
  end
end
