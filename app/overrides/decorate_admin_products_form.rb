Deface::Override.new(
  :virtual_path => "spree/admin/products/_form",
  :name => "multi_domain_admin_product_form_meta",
  :insert_bottom => "[data-hook='admin_product_form_meta']",
  :partial => "spree/admin/products/stores",
  :disabled => false)
