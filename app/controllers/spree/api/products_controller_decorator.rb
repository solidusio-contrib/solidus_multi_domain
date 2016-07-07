if SpreeMultiDomain::Engine.api_available?
  Spree::Api::ProductsController.include(SpreeMultiDomain::ShowProductSupport)
end
