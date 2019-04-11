# frozen_string_literal: true

require 'spec_helper'

describe Spree::PermissionSets::StoreDisplay do
  let(:ability) { Spree::Ability.new nil }

  subject { ability }

  context "when activated" do
    before do
      described_class.new(ability).activate!
    end

    it { should be_able_to(:display, Spree::Store) }
    it { should be_able_to(:admin, Spree::Store) }
  end

  context "when not activated" do
    it { should_not be_able_to(:display, Spree::Store) }
    it { should_not be_able_to(:admin, Spree::Store) }
  end
end

