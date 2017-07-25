if SolidusSupport.frontend_available?
  Spree::ProductsController.include(SpreeMultiDomain::ShowProductSupport)
end
