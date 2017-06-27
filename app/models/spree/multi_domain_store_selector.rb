# Class for deciding what the current store is, given an HTTP request
module Spree
  class MultiDomainStoreSelector
    def initialize(request)
      @request = request
    end

    # Chooses the current store based on a request.
    # Checks request headers for HTTP_SPREE_STORE and falls back to
    # looking up by the requesting server's name.
    # @return [Spree::Store]
    def store
      if store_key
        Spree::Store.current(store_key)
      else
        Spree::Store.default
      end
    end

    private

    def store_key
      @request.headers['HTTP_SPREE_STORE'] || @request.env['SERVER_NAME']
    end
  end
end
