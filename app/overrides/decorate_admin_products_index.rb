# frozen_string_literal: true

module DecorateAdminProductsIndex
  Deface::Override.new(
    virtual_path: "spree/admin/products/index",
    name: "multi_domain_admin_products_index_headers",
    insert_before: "[data-hook='admin_products_index_header_actions']",
    partial: "spree/admin/products/index_headers",
    disabled: false
  )

  Deface::Override.new(
    virtual_path: "spree/admin/products/index",
    name: "multi_domain_admin_products_index_rows",
    insert_before: "[data-hook='admin_products_index_row_actions']",
    partial: "spree/admin/products/index_rows",
    disabled: false
  )

  Deface::Override.new(
    virtual_path: "spree/admin/products/index",
    name: "multi_domain_admin_products_index_search",
    insert_top: "[data-hook='admin_products_index_search']",
    partial: "spree/admin/products/index_search_fields",
    disabled: false
  )
end
