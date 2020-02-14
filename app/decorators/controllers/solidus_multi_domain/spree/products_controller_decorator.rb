# frozen_string_literal: true

module SolidusMultiDomain
  module Spree
    module ProductsControllerDecorator
      def self.prepended(base)
        base.prepend SolidusMultiDomain::ShowProductSupport
      end

      ::Spree::ProductsController.prepend(self) if SolidusMultiDomain::Engine.frontend_available?
    end
  end
end
