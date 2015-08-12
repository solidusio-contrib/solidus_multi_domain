require 'spec_helper'

describe 'PaymentMethod' do
  describe '.available' do
    subject { Spree::PaymentMethod.available(display_on: :front_end, store: store) }

    let!(:check_payment_method) { FactoryGirl.create :check_payment_method }
    let(:payment_method_store) { FactoryGirl.create :store, :payment_methods => [check_payment_method] }

    context "when store is not specified" do
      let(:store) { nil }

      it { is_expected.to include(check_payment_method) }
    end

    context "when store is specified" do
      let(:store) { payment_method_store }

      context "when store has payment methods" do
        let(:non_matching_check_payment_method) { FactoryGirl.create :check_payment_method }

        it { is_expected.to include(check_payment_method) }
        it { is_expected.not_to include(non_matching_check_payment_method) }
      end

      context "when store does not have payment_methods" do
        let(:payment_method_store) { FactoryGirl.create :store }

        it { is_expected.to include(check_payment_method) }
      end
    end
  end
end
