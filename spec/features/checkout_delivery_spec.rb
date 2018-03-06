require 'spec_helper'

RSpec.describe 'Checkout delivery', type: :feature, js: true do
  let!(:zone) { create(:zone) }
  let!(:country) { create(:country) }
  let!(:store_0) { create(:store, url: 'foo.lvh.me') }
  let!(:store_1) { create(:store, url: 'bar.lvh.me') }
  let!(:product) { create(:product) }
  let!(:shipping_method_0) { create(:shipping_method, name: 'Shipping Store 0') }
  let!(:shipping_method_1) { create(:shipping_method, name: 'Shipping Store 1') }
  let!(:user) { create(:user) }
  let!(:order) { create(:order, store: store_1, user: user) }

  before(:each) do
    product.stores << store_1
    shipping_method_0.stores << store_0
    shipping_method_1.stores << store_1

    visit_store store_1, "/products/#{product.slug}"
    click_button 'Add To Cart'
    Spree::Order.last.update_column(:email, 'test@example.com')
    click_button 'Checkout'

    country = Spree::Country.first
    within('#billing') do
      fill_in 'First Name', with: 'Han'
      fill_in 'Last Name', with: 'Solo'
      fill_in 'Street Address', with: 'YT-1300'
      fill_in 'City', with: 'Mos Eisley'
      select 'United States of America', from: 'Country'
      select country.states.first, from: 'order_bill_address_attributes_state_id'
      fill_in 'Zip', with: '12010'
      fill_in 'Phone', with: '(555) 555-5555'
    end
    click_on 'Save and Continue'
  end

  it 'should show only shipping method from store' do
    expect(page).to have_current_path('/checkout/delivery')
    expect(page).not_to have_content('Shipping Store 0')
  end
end
