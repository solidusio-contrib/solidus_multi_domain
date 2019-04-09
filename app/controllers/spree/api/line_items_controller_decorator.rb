if SolidusMultiDomain::Engine.api_available?
  Spree::Api::LineItemsController.include(SolidusMultiDomain::CreateLineItemSupport)
end
