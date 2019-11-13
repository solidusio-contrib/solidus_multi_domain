# frozen_string_literal: true

module SpreeMultiDomain
  module Spree
    module Api
      module LineItemsControllerDecorator
        def self.prepended(base)
          base.prepend SpreeMultiDomain::CreateLineItemSupport
        end

        ::Spree::Api::LineItemsController.prepend(self) if SpreeMultiDomain::Engine.api_available?
      end
    end
  end
end
