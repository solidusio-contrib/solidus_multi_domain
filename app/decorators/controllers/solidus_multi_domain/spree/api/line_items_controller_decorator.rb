# frozen_string_literal: true

module SolidusMultiDomain
  module Spree
    module Api
      module LineItemsControllerDecorator
        def self.prepended(base)
          base.prepend SolidusMultiDomain::CreateLineItemSupport
        end

        ::Spree::Api::LineItemsController.prepend(self) if SolidusMultiDomain::Engine.api_available?
      end
    end
  end
end
