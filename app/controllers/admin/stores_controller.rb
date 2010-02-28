class Admin::StoresController < Admin::BaseController
  resource_controller
  ssl_required

  update.wants.html { redirect_to collection_url }
  create.wants.html { redirect_to collection_url }
  destroy.success.wants.js { render_js_for_destroy }
end
