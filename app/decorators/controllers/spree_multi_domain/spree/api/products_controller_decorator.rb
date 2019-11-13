# frozen_string_literal: true

module SpreeMultiDomain
  module Spree
    module Api
      module ProductsControllerDecorator
        def self.prepended(base)
          base.prepend SpreeMultiDomain::ShowProductSupport
        end

        ::Spree::Api::ProductsController.prepend(self) if SpreeMultiDomain::Engine.api_available?
      end
    end
  end
end
