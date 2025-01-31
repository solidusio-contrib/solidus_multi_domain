# frozen_string_literal: true

module Spree
  module PermissionSets
    class StoreManagement < PermissionSets::Base
      class << self
        def privilege
          :manage
        end

        def category
          :store
        end
      end

      def activate!
        can :manage, Spree::Store
      end
    end
  end
end
