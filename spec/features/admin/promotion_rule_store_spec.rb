require 'spec_helper'

RSpec.describe "Store promotion rule", js: true do
  stub_authorization!

  let!(:store) { create(:store, name: "Real fake doors") }
  let!(:promotion) { create(:promotion) }

  it "Can add a store rule to a promotion" do
    visit spree.edit_admin_promotion_path(promotion)

    if SolidusSupport.solidus_gem_version < Gem::Version.new('2.3.x')
      select2 "Store", from: "Add rule of type"
    else
      select "Store", from: "promotion_rule_type"
    end

    within("#rules_container") { click_button "Add" }

    select2_search store.name, from: "Choose Stores"

    within("#rules_container") { click_button "Update" }
    expect(page).to have_content('successfully updated')
  end
end
