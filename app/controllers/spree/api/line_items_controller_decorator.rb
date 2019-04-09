if SpreeMultiDomain::Engine.api_available?
  Spree::Api::LineItemsController.include(SpreeMultiDomain::LineItemSupport)
end
