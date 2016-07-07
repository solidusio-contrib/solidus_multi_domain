if SpreeMultiDomain::Engine.api_available?
  Spree::Api::LineItemsController.include(SpreeMultiDomain::CreateLineItemSupport)
end
