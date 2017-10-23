if SolidusSupport.api_available?
  Spree::Api::LineItemsController.include(SpreeMultiDomain::CreateLineItemSupport)
end
