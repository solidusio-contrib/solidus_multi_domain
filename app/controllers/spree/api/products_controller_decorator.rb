# frozen_string_literal: true

if SolidusMultiDomain::Engine.api_available?
  Spree::Api::ProductsController.include(SolidusMultiDomain::ProductSupport)
end
