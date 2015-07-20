module Spree
  module PermissionSets
    class StoreDisplay < PermissionSets::Base
      def activate!
        can [:display, :admin], Spree::Store
      end
    end
  end
end
