Deface::Override.new(
  :virtual_path => "admin/products/index",
  :name => "multi_domain_admin_products_index_headers",
  :insert_before => "[data-hook='admin_products_index_header_actions']",
  :partial => "admin/products/index_headers",
  :disabled => false)

Deface::Override.new(
  :virtual_path => "admin/products/index",
  :name => "multi_domain_admin_products_index_rows",
  :insert_before => "[data-hook='admin_products_index_row_actions']",
  :partial => "admin/products/index_rows",
  :disabled => false)
  
Deface::Override.new(
  :virtual_path => "admin/products/index",
  :name => "multi_domain_admin_products_index_search",
  :insert_top => "[data-hook='admin_products_index_search']",
  :partial => "admin/products/index_search_fields",
  :disabled => false)  

Deface::Override.new(
  :virtual_path => "admin/products/_form",
  :name => "multi_domain_admin_product_form_meta",
  :insert_bottom => "[data-hook='admin_product_form_meta']",
  :partial => "admin/products/stores",
  :disabled => false)

Deface::Override.new(
  :virtual_path => "admin/trackers/index",
  :name => "multi_domain_admin_trackers_index_headers",
  :insert_before => "[data-hook='admin_trackers_index_headers'] th:last",
  :text => "<th><%= I18n.t(:store) %></th>",
  :disabled => false)

Deface::Override.new(
  :virtual_path => "admin/trackers/index",
  :name => "multi_domain_admin_trackers_index_rows",
  :insert_before => "[data-hook='admin_trackers_index_rows'] td:last",
  :partial => "admin/trackers/index_rows",
  :disabled => false)

Deface::Override.new(
  :virtual_path => "admin/trackers/_form",
  :name => "multi_domain_additional_tracker_fields",
  :replace => "[data-hook='additional_tracker_fields']",
  :partial => "admin/trackers/store",
  :disabled => false)

Deface::Override.new(
  :virtual_path => "admin/configurations/index",
  :name => "multi_domain_admin_configurations_menu",
  :insert_bottom => "[data-hook='admin_configurations_menu']",
  :text => "<%= configurations_menu_item(I18n.t('stores_admin'), admin_stores_url, I18n.t('manage_stores')) %>",
  :disabled => false)
