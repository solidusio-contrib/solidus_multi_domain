# frozen_string_literal: true

module DecorateAdminOrdersIndex
  Deface::Override.new(
    virtual_path: "spree/admin/orders/index",
    name: "multi_domain_admin_products_index_headers",
    insert_before: "th.align-right",
    partial: "spree/admin/orders/index_headers",
    disabled: false
  )

  Deface::Override.new(
    virtual_path: "spree/admin/orders/index",
    name: "multi_domain_admin_products_index_rows",
    insert_before: "td.align-right",
    partial: "spree/admin/orders/index_rows",
    disabled: false
  )
end
