Deface::Override.new(
  virtual_path: 'spree/admin/stores/_form',
  name: 'multi_domain_form_fields',
  insert_after: "erb[loud]:contains('text_field :mail_from_address')",
  partial: 'spree/admin/stores/multi_domain_fields',
  disabled: false
)

if SolidusSupport.solidus_gem_version < Gem::Version.new('2.4.x')
  Deface::Override.new(
    virtual_path: 'spree/admin/stores/_multi_domain_fields',
    name: 'currency field',
    insert_top: "[data-hook='admin_store_multi_domain_fields']",
    partial: 'spree/admin/stores/currency_field',
    disabled: false
  )
end
