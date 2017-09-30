require 'spec_helper'

RSpec.describe 'Store configuration', type: :feature, js: true do
  stub_authorization!

  it 'should have store fields' do
    create(:payment_method)
    visit spree.new_admin_store_path

    expect(page).to have_field('store_name')
    expect(page).to have_field('store_code')
    expect(page).to have_field('store_default_true')
    expect(page).to have_field('store_default_false')
    expect(page).to have_field('store_mail_from_address')
    expect(page).to have_css('#store_default_currency_field')
    expect(page).to have_field('store_url')
    expect(page).to have_field('store_logo')
    expect(page).to have_css('#store_payment_methods_field')
    expect(page).to have_css('#store_shipping_methods_field')
    expect(page).to have_field('store_payment_method_ids_')
  end
end
