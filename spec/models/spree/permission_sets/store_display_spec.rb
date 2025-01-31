# frozen_string_literal: true

require 'solidus_multi_domain_spec_helper'

RSpec.describe Spree::PermissionSets::StoreDisplay do
  subject { ability }

  let(:ability) { Spree::Ability.new nil }

  context "when activated" do
    before do
      described_class.new(ability).activate!
    end

    it { is_expected.to be_able_to(:display, Spree::Store) }
    it { is_expected.to be_able_to(:admin, Spree::Store) }
  end

  context "when not activated" do
    it { is_expected.not_to be_able_to(:display, Spree::Store) }
    it { is_expected.not_to be_able_to(:admin, Spree::Store) }
  end
end
