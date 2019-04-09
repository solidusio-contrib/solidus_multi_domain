# frozen_string_literal: true

if SolidusMultiDomain::Engine.frontend_available?
  Spree::ProductsController.include(SolidusMultiDomain::ProductSupport)
end
