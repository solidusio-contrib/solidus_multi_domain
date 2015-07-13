Deface::Override.new(
  virtual_path: "spree/admin/shared/_configuration_menu",
  name: "multi_domain_admin_configurations_menu",
  insert_bottom: "[data-hook='admin_configurations_sidebar_menu']",
  disabled: false,
  partial: "spree/shared/multi_domain_sidebar_entry"
)
