module SpreeMultiDomain
  module BaseControllerOverrides

    def self.included(controller)
      controller.prepend_before_filter :set_store
      controller.helper :products, :taxons
    end

    private

    # Tell Rails to look in layouts/#{@store.code} whenever we're inside of a store (instead of the standard /layouts location)
    def find_layout(layout, format, html_fallback=false) #:nodoc:
      layout_dir = @current_store ? "layouts/#{@current_store.code.downcase}" : "layouts"
      view_paths.find_template(layout.to_s =~ /\A\/|layouts\// ? layout : "#{layout_dir}/#{layout}", format, html_fallback)
    rescue ActionView::MissingTemplate
      raise if Mime::Type.lookup_by_extension(format.to_s).html?
    end

    def set_store
      @current_store ||= ::Store.by_domain(request.env['SERVER_NAME']).first
      @current_store ||= ::Store.default.first
    end

    def get_taxonomies
      @taxonomies ||= Taxonomy.find(:all, :include => {:root => :children}, :conditions => ["store_id = ?", @site.id])
      @taxonomies
    end

  end
end
