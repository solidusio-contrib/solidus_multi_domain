if SolidusMultiDomain::Engine.frontend_available?
  Spree::ProductsController.include(SolidusMultiDomain::ShowProductSupport)
end
