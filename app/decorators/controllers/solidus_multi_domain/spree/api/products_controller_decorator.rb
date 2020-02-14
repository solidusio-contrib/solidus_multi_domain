# frozen_string_literal: true

module SolidusMultiDomain
  module Spree
    module Api
      module ProductsControllerDecorator
        def self.prepended(base)
          base.prepend SolidusMultiDomain::ShowProductSupport
        end

        ::Spree::Api::ProductsController.prepend(self) if SolidusMultiDomain::Engine.api_available?
      end
    end
  end
end
