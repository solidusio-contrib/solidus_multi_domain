Deface::Override.new(
  :virtual_path => "spree/admin/trackers/_form",
  :name => "multi_domain_additional_tracker_fields",
  :replace => "[data-hook='additional_tracker_fields']",
  :partial => "spree/admin/trackers/store",
  :disabled => false)
