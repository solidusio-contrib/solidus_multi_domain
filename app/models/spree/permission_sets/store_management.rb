# frozen_string_literal: true

module Spree
  module PermissionSets
    class StoreManagement < PermissionSets::Base
      def activate!
        can :manage, Spree::Store
      end
    end
  end
end
