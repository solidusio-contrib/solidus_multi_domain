module SolidusMultiDomain
  module DynamicTemplateRenderer
    def find_layout(layout, *args)
      unless api_request?
        if @view.respond_to?(:current_store) && @view.current_store && !@view.controller.is_a?(Spree::Admin::BaseController)
          store_layout = if layout.is_a?(String)
                           layout.gsub("layouts/", "layouts/#{@view.current_store.code}/")
                         else
                           layout.call.try(:gsub, "layouts/", "layouts/#{@view.current_store.code}/")
                         end

          begin
            super(store_layout, *args)
          rescue ::ActionView::MissingTemplate
            super(layout, *args)
          end
        else
          super(layout, *args)
        end
      end
    end

    def controller_name
      # check if it's not dangerous to call the method that way
      @view.controller.class.to_s
    end

    def api_request?
      return true if controller_name.include?('::Api::')
    end
  end
end
