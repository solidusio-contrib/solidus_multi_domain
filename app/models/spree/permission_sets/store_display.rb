# frozen_string_literal: true

module Spree
  module PermissionSets
    class StoreDisplay < PermissionSets::Base
      class << self
        def privilege
          :display
        end

        def category
          :store
        end
      end

      def activate!
        can [:display, :admin], Spree::Store
      end
    end
  end
end
