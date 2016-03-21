Deface::Override.new(
  :virtual_path => "spree/admin/trackers/index",
  :name => "multi_domain_admin_trackers_index_headers",
  :insert_before => "[data-hook='admin_trackers_index_headers'] th:last",
  :text => "<th><%= Spree.t(:store) %></th>",
  :disabled => false)

Deface::Override.new(
  :virtual_path => "spree/admin/trackers/index",
  :name => "multi_domain_admin_trackers_index_rows",
  :insert_before => "[data-hook='admin_trackers_index_rows'] td:last",
  :partial => "spree/admin/trackers/index_rows",
  :disabled => false)
