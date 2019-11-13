# frozen_string_literal: true

module Spree
  module PermissionSets
    class StoreDisplay < PermissionSets::Base
      def activate!
        can [:display, :admin], Spree::Store
      end
    end
  end
end
