require 'spec_helper'

describe Spree::CartonMailer do
  let(:mail) { Spree::CartonMailer.shipped_email(carton.id) }

  let(:carton) do
    FactoryGirl.create(:carton, inventory_units: order.inventory_units)
  end

  let(:order) do
    FactoryGirl.create(:order_ready_to_ship, line_items_count: 1)
  end

  describe 'from address' do
    subject do
      mail.from
    end

    context 'the order does not have a store' do
      let(:order) do
        FactoryGirl.create(:order_ready_to_ship, line_items_count: 1, store: nil)
      end

      it { is_expected.to eq [Spree::Config[:mails_from]] }
    end

    context 'the order has a store' do
      let(:order) do
        FactoryGirl.create(
          :order_ready_to_ship,
          line_items_count: 1,
          store: store,
        )
      end

      let(:store) { FactoryGirl.create(:store, mail_from_address: 'store@example.com') }
      it { is_expected.to eq ['store@example.com'] }
    end
  end

end
