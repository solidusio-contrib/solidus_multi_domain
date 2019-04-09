# frozen_string_literal: true

if SolidusMultiDomain::Engine.api_available?
  Spree::Api::LineItemsController.include(SolidusMultiDomain::LineItemSupport)
end
