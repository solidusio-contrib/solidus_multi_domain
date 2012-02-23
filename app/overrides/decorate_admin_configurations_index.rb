Deface::Override.new(
  :virtual_path => "spree/admin/configurations/index",
  :name => "multi_domain_admin_configurations_menu",
  :insert_bottom => "[data-hook='admin_configurations_menu']",
  :text => "<%= configurations_menu_item(I18n.t('stores_admin'), admin_stores_url, I18n.t('manage_stores')) %>",
  :disabled => false)
