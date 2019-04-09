if SpreeMultiDomain::Engine.frontend_available?
  Spree::ProductsController.include(SpreeMultiDomain::ProductSupport)
end
