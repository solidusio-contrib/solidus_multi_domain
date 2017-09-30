Deface::Override.new(
  virtual_path: 'spree/admin/stores/_form',
  name: 'multi_domain_form_fields',
  insert_after: "erb[loud]:contains('text_field :mail_from_address')",
  partial: 'spree/admin/stores/multi_domain_fields',
  disabled: false
)
