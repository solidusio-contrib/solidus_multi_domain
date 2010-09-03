class SpreeMultiDomainHooks < Spree::ThemeSupport::HookListener

  insert_after :admin_products_index_headers, :partial => "admin/products/index_headers"
  insert_after :admin_products_index_rows, :partial => "admin/products/index_rows"
  insert_before :admin_products_index_search, :partial => "admin/products/index_search_fields"

  insert_after :admin_product_form_meta, :partial => "admin/products/stores"

  insert_after :admin_trackers_index_headers do
    "<th>#{I18n.t(:store)}</th>"
  end
  insert_after :admin_trackers_index_rows, 'admin/trackers/index_rows'
  replace :additional_tracker_fields, 'admin/trackers/store'

  insert_after :admin_configurations_menu do
    "<%= configurations_menu_item(I18n.t('stores_admin'), admin_stores_url, I18n.t('manage_stores')) %>"
  end

end
